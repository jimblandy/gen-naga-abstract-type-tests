use std::sync::Arc;

use super::{Parameters, Scalar, Type};

pub fn gen_types() -> impl Iterator<Item = Type> {
    let linear = gen_linear_types();
    linear
        .clone()
        .chain(linear.clone().map(|linear| Type::Array {
            length: 2,
            element: Arc::new(linear.clone()),
        }))
}

pub fn gen_linear_types() -> impl Iterator<Item = Type> + Clone {
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

pub fn gen_params(ty: &Type) -> impl Iterator<Item = Parameters> {
    use std::iter;

    let leaf_scalar = ty.leaf_scalar();
    let convertible_scalars = gen_convertible_scalars(leaf_scalar);

    let mut p = vec![Parameters::Zero];

    // Include splats from all suitable scalars.
    p.extend(convertible_scalars.iter().cloned().map(Parameters::One));

    let elements = ty.elements();
    if let Some(element_ty) = ty.element_type() {
        // Include from-elements parameters for all suitable scalars.
        for &scalar in convertible_scalars.iter() {
            let parameters = iter::repeat(element_ty.replace_scalar(scalar))
                .take(elements)
                .collect();
            p.push(Parameters::Many(parameters))
        }

        // Include from-elements parameters for all suitable scalars,
        // with one parameter forcing a more specific type.
        for (i, &first) in (0..).zip(convertible_scalars) {
            for &second in convertible_scalars[i + 1..].iter() {
                for standout in 0..elements {
                    let mut parameters: Vec<_> = iter::repeat(element_ty.replace_scalar(first))
                        .take(elements)
                        .collect();

                    parameters[standout] = element_ty.replace_scalar(second);
                    p.push(Parameters::Many(parameters))
                }
            }
        }
    }

    p.into_iter()
}

pub fn gen_scalars() -> impl Iterator<Item = Scalar> + Clone {
    use Scalar::*;
    [U32, I32, F32, AbstractInt, AbstractFloat].into_iter()
}

fn gen_convertible_scalars(target: Scalar) -> &'static [Scalar] {
    match target {
        Scalar::U32 => &[Scalar::AbstractInt, Scalar::U32],
        Scalar::I32 => &[Scalar::AbstractInt, Scalar::I32],
        Scalar::F32 => &[Scalar::AbstractInt, Scalar::AbstractFloat, Scalar::F32],
        Scalar::AbstractInt => &[Scalar::AbstractInt],
        Scalar::AbstractFloat => &[Scalar::AbstractInt, Scalar::AbstractFloat],
    }
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
