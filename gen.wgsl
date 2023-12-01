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

const iaf = array<f32, 2>();

const iai = array<i32, 2>();

const iamf = array<mat2x2<f32>, 2>();

const iau = array<u32, 2>();

const iavf = array<vec2<f32>, 2>();

const iavi = array<vec2<i32>, 2>();

const iavu = array<vec2<u32>, 2>();

const if_s_f = f32(42f);

const if_saf = f32(42.0);
const if_sai = f32(42);
const ifps_f = 42f;
const ifpsaf = 42.0;
const ifpsai = 42;
const ii = i32();

const ii_s_i = i32(42i);
const ii_sai = i32(42);
const iips_i = 42i;
const iipsai = 42;
const imf = mat2x2<f32>();

const iu = u32();

const iu_s_u = u32(42u);
const iu_sai = u32(42);
const iups_u = 42u;
const iupsai = 42;
const ivf = vec2<f32>();

const ivf_s_f = vec2<f32>(42f);
const ivf_saf = vec2<f32>(42.0);
const ivf_sai = vec2<f32>(42);
const ivfps_f = vec2(42f);
const ivfpsaf = vec2(42.0);
const ivfpsai = vec2(42);
const ivi = vec2<i32>();

const ivi_s_i = vec2<i32>(42i);
const ivi_sai = vec2<i32>(42);
const ivips_i = vec2(42i);
const ivipsai = vec2(42);
const ivu = vec2<u32>();

const ivu_s_u = vec2<u32>(42u);
const ivu_sai = vec2<u32>(42);
const ivups_u = vec2(42u);
const ivupsai = vec2(42);
const not_keyword_if = f32();

const xaf: array<f32, 2> = array<f32, 2>();

const xai: array<i32, 2> = array<i32, 2>();

const xamf: array<mat2x2<f32>, 2> = array<mat2x2<f32>, 2>();

const xau: array<u32, 2> = array<u32, 2>();

const xavf: array<vec2<f32>, 2> = array<vec2<f32>, 2>();

const xavi: array<vec2<i32>, 2> = array<vec2<i32>, 2>();

const xavu: array<vec2<u32>, 2> = array<vec2<u32>, 2>();

const xf: f32 = f32();

const xf_s_f: f32 = f32(42f);
const xf_saf: f32 = f32(42.0);
const xf_sai: f32 = f32(42);
const xfps_f: f32 = 42f;
const xfpsaf: f32 = 42.0;
const xfpsai: f32 = 42;
const xi: i32 = i32();

const xi_s_i: i32 = i32(42i);
const xi_sai: i32 = i32(42);
const xips_i: i32 = 42i;
const xipsai: i32 = 42;
const xmf: mat2x2<f32> = mat2x2<f32>();

const xu: u32 = u32();

const xu_s_u: u32 = u32(42u);
const xu_sai: u32 = u32(42);
const xups_u: u32 = 42u;
const xupsai: u32 = 42;
const xvf: vec2<f32> = vec2<f32>();

const xvf_s_f: vec2<f32> = vec2<f32>(42f);
const xvf_saf: vec2<f32> = vec2<f32>(42.0);
const xvf_sai: vec2<f32> = vec2<f32>(42);
const xvfps_f: vec2<f32> = vec2(42f);
const xvfpsaf: vec2<f32> = vec2(42.0);
const xvfpsai: vec2<f32> = vec2(42);
const xvi: vec2<i32> = vec2<i32>();

const xvi_s_i: vec2<i32> = vec2<i32>(42i);
const xvi_sai: vec2<i32> = vec2<i32>(42);
const xvips_i: vec2<i32> = vec2(42i);
const xvipsai: vec2<i32> = vec2(42);
const xvu: vec2<u32> = vec2<u32>();

const xvu_s_u: vec2<u32> = vec2<u32>(42u);
const xvu_sai: vec2<u32> = vec2<u32>(42);
const xvups_u: vec2<u32> = vec2(42u);
const xvupsai: vec2<u32> = vec2(42);
