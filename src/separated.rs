pub trait Separable: Sized {
    fn with_separator<S>(self, separator: S) -> Separated<Self, S>
        where S: Default + Clone;
}

impl<I: Iterator> Separable for I {
    fn with_separator<S>(self, separator: S) -> Separated<Self, S>
        where S: Default + Clone
    {
        Separated {
            inner: self,
            separator,
            first: true
        }
    }
}

pub struct Separated<I, S> {
    inner: I,
    separator: S,
    first: bool,
}

impl<I, S> Iterator for Separated<I, S>
where I: Iterator,
      S: Default + Clone,
{
    type Item = (S, I::Item);

    fn next(&mut self) -> Option<Self::Item> {
        let Some(item) = self.inner.next() else {
            return None;
        };
        let separator = if std::mem::replace(&mut self.first, false) {
            S::default()
        } else {
            self.separator.clone()
        };
        Some((separator, item))
    }
}
