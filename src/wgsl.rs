use super::name::Name;
use super::generated::Generated;
use super::{Parameters, Scalar, Test, Type};

use std::fmt;

pub struct Wgsl<T>(pub T);

impl fmt::Display for Wgsl<&'_ Test> {
    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
        let test = self.0;
        write!(f, "const {}", Name(test))?;
        if test.decl_explicit_type {
            write!(f, ": {}", Wgsl(&test.r#type))?;
        }
        write!(f, " = ")?;

        match test {
            // For scalars, treat the non-"full constructor" case as
            // "no constructor at all", just the literal.
            Test { full_constructor: false, r#type: Type::Scalar(_), parameters: Parameters::One(ref value), .. } => {
                let root = Generated::new();
                root.with(*value).fmt(f)?;
            }
            Test { full_constructor: true, ref r#type, ref parameters, .. } => {
                write!(f, "{}", Wgsl(r#type))?;
                write!(f, "({})", Wgsl(parameters))?;
            }
            Test { ref r#type, ref parameters, .. } => {
                write!(f, "{:#}", Wgsl(r#type))?;
                write!(f, "({})", Wgsl(parameters))?;
            }
        }
        write!(f, ";")
    }
}

impl fmt::Display for Wgsl<&'_ Parameters> {
    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
        let root = Generated::new();
        match *self.0 {
            Parameters::Zero => Ok(()),
            Parameters::One(scalar) => root.with(scalar).fmt(f),
            Parameters::Many(_) => todo!(),
        }
    }
}

// Alternative format is just a bare type generator name, without
// template parameters.
impl fmt::Display for Wgsl<&'_ Type> {
    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
        let partial = f.alternate();
        match *self.0 {
            Type::Scalar(scalar) => Wgsl(scalar).fmt(f),
            Type::Vector { size, element } => {
                if partial {
                    write!(f, "vec{}", size)
                } else {
                    write!(f, "vec{}<{}>", size, Wgsl(element))
                }
            }
            Type::Matrix {
                columns,
                rows,
                element,
            } => {
                if partial {
                    write!(f, "mat{}x{}", columns, rows)
                } else {
                    write!(f, "mat{}x{}<{}>", columns, rows, Wgsl(element))
                }
            }
            Type::Array {
                length,
                ref element,
            } => {
                if partial {
                    write!(f, "array")
                } else {
                    write!(f, "array<{}, {}>", Wgsl(&**element), length)
                }
            }
        }
    }
}

impl fmt::Display for Wgsl<Scalar> {
    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
        let s = match self.0 {
            Scalar::U32 => "u32",
            Scalar::I32 => "i32",
            Scalar::F32 => "f32",
            Scalar::AbstractInt => "{AbstractInt}",
            Scalar::AbstractFloat => "{AbstractFloat}",
        };
        f.write_str(s)
    }
}
