#![allow(dead_code)]

mod name;
mod value;
mod wgsl;

use indexmap::IndexSet;

#[derive(Debug, Eq, Hash, PartialEq)]
struct Test {
    /// Does the declaration specify the type explictly, or
    /// infer it from the initializer?
    decl_explicit_type: bool,

    /// The declaration's type.
    r#type: Type,

    /// Does the constructor have a template list, or infer the
    /// element type from its arguments?
    constructor_explicit_type: bool,

    /// Parameters to the constructor.
    parameters: Parameters,
}

#[derive(Clone, Debug, Eq, Hash, PartialEq)]
enum Parameters {
    Zero,
    Splat(Scalar),
    Many(Vec<Value>),
}

#[derive(Clone, Debug, Eq, Hash, PartialEq)]
enum Type {
    Scalar(Scalar),
    Vector {
        size: usize,
        element: Scalar,
    },
    Matrix {
        columns: usize,
        rows: usize,
        element: Scalar,
    },
    Array {
        length: usize,
        element: Box<Type>,
    },
}

#[derive(Clone, Debug, Eq, Hash, PartialEq)]
enum Value {
    Typical(Type),
}

#[derive(Clone, Copy, Debug, Eq, Hash, PartialEq)]
enum Scalar {
    U32,
    I32,
    F32,
    AbstractInt,
    AbstractFloat,
}

fn main() {
    let mut seen = IndexSet::new();
    for decl_explicit_type in [true, false] {
        for r#type in gen_types() {
            for constructor_explicit_type in [true, false] {
                for parameters in gen_params(&r#type) {
                    let test = Test {
                        decl_explicit_type,
                        r#type: r#type.clone(),
                        constructor_explicit_type,
                        parameters,
                    };
                    if test.valid() {
                        let (index, new) = seen.insert_full(test);
                        if new {
                            let test = &seen[index];
                            println!("{}", wgsl::Wgsl(test));
                            //println!("{:#?}", test);
                        }
                    }
                }
            }
        }
    }
}

fn gen_types() -> impl Iterator<Item = Type> {
    let linear = gen_linear_types();
    linear
        .clone()
        .chain(linear.clone().map(|linear| Type::Array {
            length: 2,
            element: Box::new(linear.clone()),
        }))
}

fn gen_linear_types() -> impl Iterator<Item = Type> + Clone {
    use Type::*;
    gen_scalars().flat_map(|scalar| {
        [
            Scalar(scalar),
            Vector {
                size: 2,
                element: scalar,
            },
            Matrix {
                columns: 2,
                rows: 2,
                element: scalar,
            },
        ]
    })
}

fn gen_scalars() -> impl Iterator<Item = Scalar> + Clone {
    use Scalar::*;
    [U32, I32, F32, AbstractInt, AbstractFloat].into_iter()
}

fn gen_params(_ty: &Type) -> impl Iterator<Item = Parameters> {
    [Parameters::Zero].into_iter()
}

fn cartesian<A, B, AI, BI>(outer: AI, inner: BI) -> impl Iterator<Item = (A, B)>
where
    A: Clone,
    AI: IntoIterator<Item = A>,
    BI: Clone + IntoIterator<Item = B>,
{
    outer
        .into_iter()
        .flat_map(move |a| inner.clone().into_iter().map(move |b| (a.clone(), b)))
}

impl Test {
    fn valid(&self) -> bool {
        match *self {
            Test {
                r#type: Type::Scalar(_),
                ..
            } if !self.constructor_explicit_type => return false,
            Test {
                constructor_explicit_type: false,
                parameters: Parameters::Zero,
                ..
            } => return false,
            Test {
                r#type: Type::Matrix { element, .. },
                ..
            } if element != Scalar::F32 => return false,
            Test {
                decl_explicit_type: true,
                ref r#type,
                ..
            } if r#type.leaf_scalar().is_abstract() => return false,
            Test {
                constructor_explicit_type: true,
                ref r#type,
                ..
            } if r#type.leaf_scalar().is_abstract() => return false,
            _ => {}
        }

        true
    }
}

impl Type {
    fn leaf_scalar(&self) -> Scalar {
        match *self {
            Type::Scalar(scalar) => scalar,
            Type::Vector { element, .. } | Type::Matrix { element, .. } => element,
            Type::Array { ref element, .. } => element.leaf_scalar(),
        }
    }
}

impl Scalar {
    fn is_abstract(self) -> bool {
        match self {
            Scalar::U32 | Scalar::I32 | Scalar::F32 => false,
            Scalar::AbstractInt | Scalar::AbstractFloat => true,
        }
    }
}
