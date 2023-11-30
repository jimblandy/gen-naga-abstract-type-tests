use super::{name::Name, Parameters, Scalar, Test, Type};

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
        if test.constructor_explicit_type {
            write!(f, "{}", Wgsl(&test.r#type))?;
        } else {
            write!(f, "{:#}", Wgsl(&test.r#type))?;
        }
        write!(f, "({})", Wgsl(&test.parameters))?;
        Ok(())
    }
}

impl fmt::Display for Wgsl<&'_ Parameters> {
    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
        match self.0 {
            Parameters::Zero => Ok(()),
            Parameters::Splat(_) => todo!(),
            Parameters::Many(_) => todo!(),
        }
    }
}

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
