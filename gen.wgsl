// i/x: type inferred / explicit
// X/vX/mX: vector / matrix of X
//     where X: u/i/f: u32 / i32 / f32
// aX: array of any of the above
// s: single parameter: vector splat, conversion
// r: vector spread (vector arg to vector constructor)
// p: "partial" constructor (type parameter inferred)
// u/i/f/ai/af: u32 / i32 / f32 / abstract float / abstract integer as parameter
// _: just for alignment

// Ensure that:
// - the inferred type is correct.
// - all parameters' types are considered.
// - all parameters are converted to the consensus type.


const iaf = array<f32, 2>();
const iaf__f_f = array<f32, 2>(42f, 43f);
const iaf_afaf = array<f32, 2>(42.0, 43.0);
const iaf_aiai = array<f32, 2>(42, 43);
const iafp_f_f = array(42f, 43f);
const iafpafaf = array(42.0, 43.0);
const iafpaiai = array(42, 43);

const iai = array<i32, 2>();
const iai__i_i = array<i32, 2>(42i, 43i);
const iai_aiai = array<i32, 2>(42, 43);
const iaip_i_i = array(42i, 43i);
const iaipaiai = array(42, 43);

const iamf = array<mat2x2<f32>, 2>();
const iamf_mafmaf = array<mat2x2<f32>, 2>(mat2x2(42.0, 43.0, 44.0, 45.0), mat2x2(46.0, 47.0, 48.0, 49.0));
const iamf_maimai = array<mat2x2<f32>, 2>(mat2x2(42, 43, 44, 45), mat2x2(46, 47, 48, 49));
const iamf_mfmf = array<mat2x2<f32>, 2>(mat2x2(42f, 43f, 44f, 45f), mat2x2(46f, 47f, 48f, 49f));
const iamfpmafmaf = array(mat2x2(42.0, 43.0, 44.0, 45.0), mat2x2(46.0, 47.0, 48.0, 49.0));
const iamfpmaimai = array(mat2x2(42, 43, 44, 45), mat2x2(46, 47, 48, 49));
const iamfpmfmf = array(mat2x2(42f, 43f, 44f, 45f), mat2x2(46f, 47f, 48f, 49f));

const iau = array<u32, 2>();
const iau__u_u = array<u32, 2>(42u, 43u);
const iau_aiai = array<u32, 2>(42, 43);
const iaup_u_u = array(42u, 43u);
const iaupaiai = array(42, 43);

const iavf = array<vec2<f32>, 2>();
const iavf_vafvaf = array<vec2<f32>, 2>(vec2(42.0, 43.0), vec2(44.0, 45.0));
const iavf_vaivai = array<vec2<f32>, 2>(vec2(42, 43), vec2(44, 45));
const iavf_vfvf = array<vec2<f32>, 2>(vec2(42f, 43f), vec2(44f, 45f));
const iavfpvafvaf = array(vec2(42.0, 43.0), vec2(44.0, 45.0));
const iavfpvaivai = array(vec2(42, 43), vec2(44, 45));
const iavfpvfvf = array(vec2(42f, 43f), vec2(44f, 45f));

const iavi = array<vec2<i32>, 2>();
const iavi_vaivai = array<vec2<i32>, 2>(vec2(42, 43), vec2(44, 45));
const iavi_vivi = array<vec2<i32>, 2>(vec2(42i, 43i), vec2(44i, 45i));
const iavipvaivai = array(vec2(42, 43), vec2(44, 45));
const iavipvivi = array(vec2(42i, 43i), vec2(44i, 45i));

const iavu = array<vec2<u32>, 2>();
const iavu_vaivai = array<vec2<u32>, 2>(vec2(42, 43), vec2(44, 45));
const iavu_vuvu = array<vec2<u32>, 2>(vec2(42u, 43u), vec2(44u, 45u));
const iavupvaivai = array(vec2(42, 43), vec2(44, 45));
const iavupvuvu = array(vec2(42u, 43u), vec2(44u, 45u));

const if_saf = f32(42.0);
const if_sai = f32(42);
const if_sf = f32(42f);
const ifpsaf = 42.0;
const ifpsai = 42;
const ifpsf = 42f;

const ii = i32();
const ii_sai = i32(42);
const ii_si = i32(42i);
const iipsai = 42;
const iipsi = 42i;

const imf = mat2x2<f32>();
const imf__f_f_f_f = mat2x2<f32>(42f, 43f, 44f, 45f);
const imf_afafafaf = mat2x2<f32>(42.0, 43.0, 44.0, 45.0);
const imf_aiaiaiai = mat2x2<f32>(42, 43, 44, 45);
const imfp_f_f_f_f = mat2x2(42f, 43f, 44f, 45f);
const imfpafafafaf = mat2x2(42.0, 43.0, 44.0, 45.0);
const imfpaiaiaiai = mat2x2(42, 43, 44, 45);

const iu = u32();
const iu_sai = u32(42);
const iu_su = u32(42u);
const iupsai = 42;
const iupsu = 42u;

const ivf = vec2<f32>();
const ivf__f_f = vec2<f32>(42f, 43f);
const ivf_afaf = vec2<f32>(42.0, 43.0);
const ivf_aiai = vec2<f32>(42, 43);
const ivf_saf = vec2<f32>(42.0);
const ivf_sai = vec2<f32>(42);
const ivf_sf = vec2<f32>(42f);
const ivfp_f_f = vec2(42f, 43f);
const ivfpafaf = vec2(42.0, 43.0);
const ivfpaiai = vec2(42, 43);
const ivfpsaf = vec2(42.0);
const ivfpsai = vec2(42);
const ivfpsf = vec2(42f);

const ivi = vec2<i32>();
const ivi__i_i = vec2<i32>(42i, 43i);
const ivi_aiai = vec2<i32>(42, 43);
const ivi_sai = vec2<i32>(42);
const ivi_si = vec2<i32>(42i);
const ivip_i_i = vec2(42i, 43i);
const ivipaiai = vec2(42, 43);
const ivipsai = vec2(42);
const ivipsi = vec2(42i);

const ivu = vec2<u32>();
const ivu__u_u = vec2<u32>(42u, 43u);
const ivu_aiai = vec2<u32>(42, 43);
const ivu_sai = vec2<u32>(42);
const ivu_su = vec2<u32>(42u);
const ivup_u_u = vec2(42u, 43u);
const ivupaiai = vec2(42, 43);
const ivupsai = vec2(42);
const ivupsu = vec2(42u);

const not_keyword_if = f32();

const xaf: array<f32, 2> = array<f32, 2>();
const xaf__f_f: array<f32, 2> = array<f32, 2>(42f, 43f);
const xaf_afaf: array<f32, 2> = array<f32, 2>(42.0, 43.0);
const xaf_aiai: array<f32, 2> = array<f32, 2>(42, 43);
const xafp_f_f: array<f32, 2> = array(42f, 43f);
const xafpafaf: array<f32, 2> = array(42.0, 43.0);
const xafpaiai: array<f32, 2> = array(42, 43);

const xai: array<i32, 2> = array<i32, 2>();
const xai__i_i: array<i32, 2> = array<i32, 2>(42i, 43i);
const xai_aiai: array<i32, 2> = array<i32, 2>(42, 43);
const xaip_i_i: array<i32, 2> = array(42i, 43i);
const xaipaiai: array<i32, 2> = array(42, 43);

const xamf: array<mat2x2<f32>, 2> = array<mat2x2<f32>, 2>();
const xamf_mafmaf: array<mat2x2<f32>, 2> = array<mat2x2<f32>, 2>(mat2x2(42.0, 43.0, 44.0, 45.0), mat2x2(46.0, 47.0, 48.0, 49.0));
const xamf_maimai: array<mat2x2<f32>, 2> = array<mat2x2<f32>, 2>(mat2x2(42, 43, 44, 45), mat2x2(46, 47, 48, 49));
const xamf_mfmf: array<mat2x2<f32>, 2> = array<mat2x2<f32>, 2>(mat2x2(42f, 43f, 44f, 45f), mat2x2(46f, 47f, 48f, 49f));
const xamfpmafmaf: array<mat2x2<f32>, 2> = array(mat2x2(42.0, 43.0, 44.0, 45.0), mat2x2(46.0, 47.0, 48.0, 49.0));
const xamfpmaimai: array<mat2x2<f32>, 2> = array(mat2x2(42, 43, 44, 45), mat2x2(46, 47, 48, 49));
const xamfpmfmf: array<mat2x2<f32>, 2> = array(mat2x2(42f, 43f, 44f, 45f), mat2x2(46f, 47f, 48f, 49f));

const xau: array<u32, 2> = array<u32, 2>();
const xau__u_u: array<u32, 2> = array<u32, 2>(42u, 43u);
const xau_aiai: array<u32, 2> = array<u32, 2>(42, 43);
const xaup_u_u: array<u32, 2> = array(42u, 43u);
const xaupaiai: array<u32, 2> = array(42, 43);

const xavf: array<vec2<f32>, 2> = array<vec2<f32>, 2>();
const xavf_vafvaf: array<vec2<f32>, 2> = array<vec2<f32>, 2>(vec2(42.0, 43.0), vec2(44.0, 45.0));
const xavf_vaivai: array<vec2<f32>, 2> = array<vec2<f32>, 2>(vec2(42, 43), vec2(44, 45));
const xavf_vfvf: array<vec2<f32>, 2> = array<vec2<f32>, 2>(vec2(42f, 43f), vec2(44f, 45f));
const xavfpvafvaf: array<vec2<f32>, 2> = array(vec2(42.0, 43.0), vec2(44.0, 45.0));
const xavfpvaivai: array<vec2<f32>, 2> = array(vec2(42, 43), vec2(44, 45));
const xavfpvfvf: array<vec2<f32>, 2> = array(vec2(42f, 43f), vec2(44f, 45f));

const xavi: array<vec2<i32>, 2> = array<vec2<i32>, 2>();
const xavi_vaivai: array<vec2<i32>, 2> = array<vec2<i32>, 2>(vec2(42, 43), vec2(44, 45));
const xavi_vivi: array<vec2<i32>, 2> = array<vec2<i32>, 2>(vec2(42i, 43i), vec2(44i, 45i));
const xavipvaivai: array<vec2<i32>, 2> = array(vec2(42, 43), vec2(44, 45));
const xavipvivi: array<vec2<i32>, 2> = array(vec2(42i, 43i), vec2(44i, 45i));

const xavu: array<vec2<u32>, 2> = array<vec2<u32>, 2>();
const xavu_vaivai: array<vec2<u32>, 2> = array<vec2<u32>, 2>(vec2(42, 43), vec2(44, 45));
const xavu_vuvu: array<vec2<u32>, 2> = array<vec2<u32>, 2>(vec2(42u, 43u), vec2(44u, 45u));
const xavupvaivai: array<vec2<u32>, 2> = array(vec2(42, 43), vec2(44, 45));
const xavupvuvu: array<vec2<u32>, 2> = array(vec2(42u, 43u), vec2(44u, 45u));

const xf: f32 = f32();
const xf_saf: f32 = f32(42.0);
const xf_sai: f32 = f32(42);
const xf_sf: f32 = f32(42f);
const xfpsaf: f32 = 42.0;
const xfpsai: f32 = 42;
const xfpsf: f32 = 42f;

const xi: i32 = i32();
const xi_sai: i32 = i32(42);
const xi_si: i32 = i32(42i);
const xipsai: i32 = 42;
const xipsi: i32 = 42i;

const xmf: mat2x2<f32> = mat2x2<f32>();
const xmf__f_f_f_f: mat2x2<f32> = mat2x2<f32>(42f, 43f, 44f, 45f);
const xmf_afafafaf: mat2x2<f32> = mat2x2<f32>(42.0, 43.0, 44.0, 45.0);
const xmf_aiaiaiai: mat2x2<f32> = mat2x2<f32>(42, 43, 44, 45);
const xmfp_f_f_f_f: mat2x2<f32> = mat2x2(42f, 43f, 44f, 45f);
const xmfpafafafaf: mat2x2<f32> = mat2x2(42.0, 43.0, 44.0, 45.0);
const xmfpaiaiaiai: mat2x2<f32> = mat2x2(42, 43, 44, 45);

const xu: u32 = u32();
const xu_sai: u32 = u32(42);
const xu_su: u32 = u32(42u);
const xupsai: u32 = 42;
const xupsu: u32 = 42u;

const xvf: vec2<f32> = vec2<f32>();
const xvf__f_f: vec2<f32> = vec2<f32>(42f, 43f);
const xvf_afaf: vec2<f32> = vec2<f32>(42.0, 43.0);
const xvf_aiai: vec2<f32> = vec2<f32>(42, 43);
const xvf_saf: vec2<f32> = vec2<f32>(42.0);
const xvf_sai: vec2<f32> = vec2<f32>(42);
const xvf_sf: vec2<f32> = vec2<f32>(42f);
const xvfp_f_f: vec2<f32> = vec2(42f, 43f);
const xvfpafaf: vec2<f32> = vec2(42.0, 43.0);
const xvfpaiai: vec2<f32> = vec2(42, 43);
const xvfpsaf: vec2<f32> = vec2(42.0);
const xvfpsai: vec2<f32> = vec2(42);
const xvfpsf: vec2<f32> = vec2(42f);

const xvi: vec2<i32> = vec2<i32>();
const xvi__i_i: vec2<i32> = vec2<i32>(42i, 43i);
const xvi_aiai: vec2<i32> = vec2<i32>(42, 43);
const xvi_sai: vec2<i32> = vec2<i32>(42);
const xvi_si: vec2<i32> = vec2<i32>(42i);
const xvip_i_i: vec2<i32> = vec2(42i, 43i);
const xvipaiai: vec2<i32> = vec2(42, 43);
const xvipsai: vec2<i32> = vec2(42);
const xvipsi: vec2<i32> = vec2(42i);

const xvu: vec2<u32> = vec2<u32>();
const xvu__u_u: vec2<u32> = vec2<u32>(42u, 43u);
const xvu_aiai: vec2<u32> = vec2<u32>(42, 43);
const xvu_sai: vec2<u32> = vec2<u32>(42);
const xvu_su: vec2<u32> = vec2<u32>(42u);
const xvup_u_u: vec2<u32> = vec2(42u, 43u);
const xvupaiai: vec2<u32> = vec2(42, 43);
const xvupsai: vec2<u32> = vec2(42);
const xvupsu: vec2<u32> = vec2(42u);
