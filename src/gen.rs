use super::{Parameters, Scalar, Type};

pub fn gen_types() -> impl Iterator<Item = Type> {
    let linear = gen_linear_types();
    linear
        .clone()
        .chain(linear.clone().map(|linear| Type::Array {
            length: 2,
            element: Box::new(linear.clone()),
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
    let leaf_scalar = ty.leaf_scalar();
    let convertible_scalars = gen_convertible_scalars(leaf_scalar);

    let mut p = vec![Parameters::Zero];

    // Include splats from all suitable scalars.
    p.extend(convertible_scalars.clone().map(Parameters::Splat));

    p.into_iter()
}

pub fn gen_scalars() -> impl Iterator<Item = Scalar> + Clone {
    use Scalar::*;
    [U32, I32, F32, AbstractInt, AbstractFloat].into_iter()
}

pub fn gen_convertible_scalars(target: Scalar) -> impl Iterator<Item = Scalar> + Clone {
    match target {
        Scalar::U32 => [Scalar::AbstractInt, Scalar::U32].iter().cloned(),
        Scalar::I32 => [Scalar::AbstractInt, Scalar::I32].iter().cloned(),
        Scalar::F32 => [Scalar::AbstractInt, Scalar::AbstractFloat, Scalar::F32].iter().cloned(),
        Scalar::AbstractInt => [Scalar::AbstractInt].iter().cloned(),
        Scalar::AbstractFloat => [Scalar::AbstractInt, Scalar::AbstractFloat].iter().cloned(),
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
