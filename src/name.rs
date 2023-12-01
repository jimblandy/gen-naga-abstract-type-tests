use std::fmt;

use super::{Parameters, Scalar, Test, Type, Value};

#[derive(Debug)]
pub struct Name<T>(pub T);

impl fmt::Display for Name<&'_ Test> {
    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
        let test = self.0;

        if *test
            == (Test {
                decl_explicit_type: false,
                r#type: Type::Scalar(Scalar::F32),
                full_constructor: true,
                parameters: Parameters::Zero,
            })
        {
            write!(f, "not_keyword_")?;
        }

        f.write_str(if test.decl_explicit_type { "x" } else { "i" })?;
        write!(f, "{}", Name(&test.r#type))?;
        if !test.full_constructor {
            f.write_str("p")?;
        } else if test.parameters != Parameters::Zero {
            f.write_str("_")?;
        }
        write!(f, "{}", Name(&test.parameters))?;
        Ok(())
    }
}

impl fmt::Display for Name<&'_ Parameters> {
    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
        match *self.0 {
            Parameters::Zero => Ok(()),
            Parameters::Splat(scalar) => {
                write!(f, "s{}", Name(&Value::Typical(Type::Scalar(scalar))))
            }
            Parameters::Many(ref values) => {
                for value in values {
                    Name(value).fmt(f)?;
                }
                Ok(())
            }
        }
    }
}

impl fmt::Display for Name<&'_ Type> {
    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
        match *self.0 {
            Type::Scalar(scalar) => Name(scalar).fmt(f),
            Type::Vector { element, .. } => write!(f, "v{}", Name(element)),
            Type::Matrix { element, .. } => write!(f, "m{}", Name(element)),
            Type::Array { ref element, .. } => write!(f, "a{}", Name(&**element)),
        }
    }
}

impl fmt::Display for Name<&'_ Value> {
    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
        match self.0 {
            Value::Typical(ref r#type) => write!(f, "{:_>2}", Name(r#type)),
        }
    }
}

impl fmt::Display for Name<Scalar> {
    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
        let string = match self.0 {
            Scalar::U32 => "u",
            Scalar::I32 => "i",
            Scalar::F32 => "f",
            Scalar::AbstractInt => "ai",
            Scalar::AbstractFloat => "af",
        };
        string.fmt(f)
    }
}

#[test]
fn xvupaiai() {
    let t = Test {
        decl_explicit_type: true,
        r#type: Type::Vector {
            size: 2,
            element: Scalar::U32,
        },
        full_constructor: false,
        parameters: Parameters::Many(vec![
            Value::Typical(Type::Scalar(Scalar::AbstractInt)),
            Value::Typical(Type::Scalar(Scalar::AbstractInt)),
        ]),
    };
    assert_eq!(Name(&t).to_string(), "xvupaiai");
}

#[test]
fn xvfpaiai() {
    let t = Test {
        decl_explicit_type: true,
        r#type: Type::Vector {
            size: 2,
            element: Scalar::F32,
        },
        full_constructor: false,
        parameters: Parameters::Many(vec![
            Value::Typical(Type::Scalar(Scalar::AbstractInt)),
            Value::Typical(Type::Scalar(Scalar::AbstractInt)),
        ]),
    };
    assert_eq!(Name(&t).to_string(), "xvfpaiai");
}

#[test]
fn xvuuai() {
    let t = Test {
        decl_explicit_type: true,
        r#type: Type::Vector {
            size: 2,
            element: Scalar::U32,
        },
        full_constructor: true,
        parameters: Parameters::Many(vec![
            Value::Typical(Type::Scalar(Scalar::U32)),
            Value::Typical(Type::Scalar(Scalar::AbstractInt)),
        ]),
    };
    assert_eq!(Name(&t).to_string(), "xvuuai");
}

#[test]
fn xvuaiu() {
    let t = Test {
        decl_explicit_type: true,
        r#type: Type::Vector {
            size: 2,
            element: Scalar::U32,
        },
        full_constructor: true,
        parameters: Parameters::Many(vec![
            Value::Typical(Type::Scalar(Scalar::AbstractInt)),
            Value::Typical(Type::Scalar(Scalar::U32)),
        ]),
    };
    assert_eq!(Name(&t).to_string(), "xvuaiu");
}

#[test]
fn xmfp() {
    fn gen(i: Option<usize>) -> Test {
        let mut params: Vec<Value> =
            std::iter::repeat(Value::Typical(Type::Scalar(Scalar::AbstractInt)))
                .take(4)
                .collect();
        if let Some(i) = i {
            params[i] = Value::Typical(Type::Scalar(Scalar::AbstractFloat));
        }

        Test {
            decl_explicit_type: true,
            r#type: Type::Matrix {
                columns: 2,
                rows: 2,
                element: Scalar::F32,
            },
            full_constructor: false,
            parameters: Parameters::Many(params),
        }
    }

    assert_eq!(Name(&gen(None)).to_string(), "xmfpaiaiaiai");
    assert_eq!(Name(&gen(Some(0))).to_string(), "xmfpafaiaiai");
    assert_eq!(Name(&gen(Some(1))).to_string(), "xmfpaiafaiai");
    assert_eq!(Name(&gen(Some(2))).to_string(), "xmfpaiaiafai");
    assert_eq!(Name(&gen(Some(3))).to_string(), "xmfpaiaiaiaf");
}
// const xmfpaiaiaiai: mat2x2<f32> = mat2x2(1, 2, 3, 4);
// const xmfpafaiaiai: mat2x2<f32> = mat2x2(1.0, 2, 3, 4);
// const xmfpaiafaiai: mat2x2<f32> = mat2x2(1, 2.0, 3, 4);
// const xmfpaiaiafai: mat2x2<f32> = mat2x2(1, 2, 3.0, 4);
// const xmfpaiaiaiaf: mat2x2<f32> = mat2x2(1, 2, 3, 4.0);
//
// const imfpaiaiaiai = mat2x2(1, 2, 3, 4);
// const imfpafaiaiai = mat2x2(1.0, 2, 3, 4);
// const imfpafafafaf = mat2x2(1.0, 2.0, 3.0, 4.0);
//
// const xmfp_faiaiai: mat2x2<f32> = mat2x2(1.0f, 2, 3, 4);
// const xmfpai_faiai: mat2x2<f32> = mat2x2(1, 2.0f, 3, 4);
// const xmfpaiai_fai: mat2x2<f32> = mat2x2(1, 2, 3.0f, 4);
// const xmfpaiaiai_f: mat2x2<f32> = mat2x2(1, 2, 3, 4.0f);
