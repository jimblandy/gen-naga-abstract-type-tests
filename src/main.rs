#![allow(dead_code)]

use std::collections::btree_map;

mod gen;
mod name;
mod value;
mod wgsl;

#[derive(Debug, Eq, Hash, PartialEq)]
struct Test {
    /// Does the declaration specify the type explictly, or
    /// infer it from the initializer?
    decl_explicit_type: bool,

    /// The declaration's type.
    r#type: Type,

    /// Does the constructor have a template list, or infer the
    /// element type from its arguments?
    full_constructor: bool,

    /// Parameters to the constructor.
    parameters: Parameters,
}

#[derive(Clone, Debug, Eq, Hash, PartialEq)]
enum Parameters {
    Zero,
    One(Scalar),
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
    let mut seen = std::collections::BTreeMap::new();
    for decl_explicit_type in [true, false] {
        for r#type in gen::gen_types() {
            for full_constructor in [true, false] {
                for parameters in gen::gen_params(&r#type) {
                    let test = Test {
                        decl_explicit_type,
                        r#type: r#type.clone(),
                        full_constructor,
                        parameters,
                    };
                    if !test.is_valid() {
                        continue;
                    }

                    let name = name::Name(&test).to_string();
                    match seen.entry(name) {
                        btree_map::Entry::Vacant(v) => {
                            v.insert(test);
                        }
                        btree_map::Entry::Occupied(o) => {
                            if o.get() != &test {
                                eprintln!("warning: different tests have the same name {:?}:", o.key());
                                eprintln!();
                                eprintln!("{:#?}", o.get());
                                eprintln!();
                                eprintln!("{:#?}", test);
                            }
                        }
                    }
                }
            }
        }
    }

    let mut prior_type = None;
    for test in seen.values() {
        println!("{}", wgsl::Wgsl(test));
        if Some(&test.r#type) != prior_type {
            println!();
            prior_type = Some(&test.r#type);
        }
        //println!("{:#?}", test);
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

    fn is_valid(&self) -> bool {
        match *self {
            Type::Scalar(_) | Type::Vector { .. } => true,
            Type::Matrix { element, .. } => element.is_float(),
            Type::Array { ref element, .. } => element.is_valid(),
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

    fn is_float(self) -> bool {
        match self {
            Scalar::U32 | Scalar::I32 | Scalar::AbstractInt => false,
            Scalar::AbstractFloat | Scalar::F32 => true,
        }
    }
}

impl Test {
    fn is_valid(&self) -> bool {
        match *self {
            // Some types aren't valid WGSL at all, like `mat2x2<u32>`.
            Test { ref r#type, .. } if !r#type.is_valid() => return false,

            // Vectors have splats, and scalars are naturally a single value.
            Test {
                ref r#type,
                parameters: Parameters::One(_),
                ..
            } if !matches!(r#type, Type::Scalar(_) | Type::Vector { .. }) => return false,

            // If the scalar type is abstract, we can't write it out.
            Test {
                decl_explicit_type: decl,
                full_constructor: con,
                ref r#type,
                ..
            } if r#type.leaf_scalar().is_abstract() && (decl || con) => return false,

            // Things Naga should support eventually:

            // WGSL does support zero-value constructors without
            // template lists, but Naga doesn't support them yet.
            Test {
                full_constructor: false,
                parameters: Parameters::Zero,
                ..
            } => return false,

            // WGSL does support constants with abstract types, but
            // Naga doesn't implement them yet. For now, skip them.
            Test { ref r#type, .. } if r#type.leaf_scalar().is_abstract() => return false,

            _ => {}
        }

        true
    }
}
