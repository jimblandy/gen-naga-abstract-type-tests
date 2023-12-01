// i/x: type inferred / explicit
// X/vX/mX: vector / matrix of X
//     where X: u/i/f: u32 / i32 / f32
// aX: array of any of the above
// s: vector splat
// r: vector spread (vector arg to vector constructor)
// p: "partial" constructor (type parameter inferred)
// u/i/f/ai/af: u32 / i32 / f32 / abstract float / abstract integer as parameter
// _: just for alignment

// Ensure that:
// - the inferred type is correct.
// - all parameters' types are considered.
// - all parameters are converted to the consensus type.

