use std::{
    fmt,
    sync::{atomic::AtomicI32, Arc},
};

use super::{Parameters, Scalar, Type};
use crate::separated::Separable as _;

pub struct Generated<T> {
    data: T,
    state: Arc<State>,
}

impl Generated<()> {
    pub fn new() -> Generated<()> {
        Generated {
            data: (),
            state: Arc::new(State::default()),
        }
    }
}

impl<T> Generated<T> {
    pub fn with<U>(&self, data: U) -> Generated<U> {
        Generated {
            data,
            state: self.state.clone(),
        }
    }
}

pub trait Generate<T> {
    fn generate(&self) -> T;
}

impl<T, U> Generate<T> for Generated<U>
where
    State: Generate<T>,
{
    fn generate(&self) -> T {
        self.state.generate()
    }
}

impl fmt::Display for Generated<&'_ Parameters> {
    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
        match *self.data {
            Parameters::Zero => Ok(()),
            Parameters::One(scalar) => self.with(scalar).fmt(f),
            Parameters::Many(ref parameters) => {
                for (sep, ty) in parameters.iter().with_separator(", ") {
                    write!(f, "{}{}", sep, self.with(ty))?;
                }
                Ok(())
            }
        }
    }
}

impl fmt::Display for Generated<&'_ Type> {
    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
        match *self.data {
            Type::Scalar(scalar) => self.with(scalar).fmt(f),
            ref ty => {
                let size = ty.elements();
                let element_ty = ty.element_type().unwrap();
                let leaf_gen = self.with(element_ty.as_ref());
                write!(f, "{:#}(", super::wgsl::Wgsl(ty))?;
                for (sep, _) in (0..size).with_separator(", ") {
                    write!(f, "{}{}", sep, leaf_gen)?;
                }
                write!(f, ")")
            }
        }
    }
}

impl fmt::Display for Generated<Scalar> {
    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
        match self.data {
            Scalar::U32 => write!(f, "{}u", Generate::<u32>::generate(self)),
            Scalar::I32 => write!(f, "{}i", Generate::<i32>::generate(self)),
            Scalar::F32 => write!(f, "{}f", Generate::<f32>::generate(self)),
            Scalar::AbstractInt => write!(f, "{}", Generate::<i32>::generate(self)),
            Scalar::AbstractFloat => write!(f, "{:?}", Generate::<f32>::generate(self)),
        }
    }
}

pub struct State {
    next: AtomicI32,
}

impl Default for State {
    fn default() -> Self {
        Self {
            next: AtomicI32::new(42),
        }
    }
}

impl Generate<i32> for State {
    fn generate(&self) -> i32 {
        self.next.fetch_add(1, std::sync::atomic::Ordering::SeqCst)
    }
}

impl Generate<u32> for State {
    fn generate(&self) -> u32 {
        self.next.fetch_add(1, std::sync::atomic::Ordering::SeqCst) as u32
    }
}

impl Generate<f32> for State {
    fn generate(&self) -> f32 {
        self.next.fetch_add(1, std::sync::atomic::Ordering::SeqCst) as f32
    }
}
