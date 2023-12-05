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
const iaf__faf = array<f32, 2>(42f, 43.0);
const iaf__fai = array<f32, 2>(42f, 43);
const iaf_af_f = array<f32, 2>(42.0, 43f);
const iaf_afaf = array<f32, 2>(42.0, 43.0);
const iaf_afai = array<f32, 2>(42.0, 43);
const iaf_ai_f = array<f32, 2>(42, 43f);
const iaf_aiaf = array<f32, 2>(42, 43.0);
const iaf_aiai = array<f32, 2>(42, 43);
const iafp_f_f = array(42f, 43f);
const iafp_faf = array(42f, 43.0);
const iafp_fai = array(42f, 43);
const iafpaf_f = array(42.0, 43f);
const iafpafaf = array(42.0, 43.0);
const iafpafai = array(42.0, 43);
const iafpai_f = array(42, 43f);
const iafpaiaf = array(42, 43.0);
const iafpaiai = array(42, 43);

const iai = array<i32, 2>();
const iai__i_i = array<i32, 2>(42i, 43i);
const iai__iai = array<i32, 2>(42i, 43);
const iai_ai_i = array<i32, 2>(42, 43i);
const iai_aiai = array<i32, 2>(42, 43);
const iaip_i_i = array(42i, 43i);
const iaip_iai = array(42i, 43);
const iaipai_i = array(42, 43i);
const iaipaiai = array(42, 43);

const iamf = array<mat2x2<f32>, 2>();
const iamf_mafmaf = array<mat2x2<f32>, 2>(mat2x2(42.0, 43.0, 44.0, 45.0), mat2x2(46.0, 47.0, 48.0, 49.0));
const iamf_mafmai = array<mat2x2<f32>, 2>(mat2x2(42.0, 43.0, 44.0, 45.0), mat2x2(46, 47, 48, 49));
const iamf_mafmf = array<mat2x2<f32>, 2>(mat2x2(42.0, 43.0, 44.0, 45.0), mat2x2(46f, 47f, 48f, 49f));
const iamf_maimaf = array<mat2x2<f32>, 2>(mat2x2(42, 43, 44, 45), mat2x2(46.0, 47.0, 48.0, 49.0));
const iamf_maimai = array<mat2x2<f32>, 2>(mat2x2(42, 43, 44, 45), mat2x2(46, 47, 48, 49));
const iamf_maimf = array<mat2x2<f32>, 2>(mat2x2(42, 43, 44, 45), mat2x2(46f, 47f, 48f, 49f));
const iamf_mfmaf = array<mat2x2<f32>, 2>(mat2x2(42f, 43f, 44f, 45f), mat2x2(46.0, 47.0, 48.0, 49.0));
const iamf_mfmai = array<mat2x2<f32>, 2>(mat2x2(42f, 43f, 44f, 45f), mat2x2(46, 47, 48, 49));
const iamf_mfmf = array<mat2x2<f32>, 2>(mat2x2(42f, 43f, 44f, 45f), mat2x2(46f, 47f, 48f, 49f));
const iamfpmafmaf = array(mat2x2(42.0, 43.0, 44.0, 45.0), mat2x2(46.0, 47.0, 48.0, 49.0));
const iamfpmafmai = array(mat2x2(42.0, 43.0, 44.0, 45.0), mat2x2(46, 47, 48, 49));
const iamfpmafmf = array(mat2x2(42.0, 43.0, 44.0, 45.0), mat2x2(46f, 47f, 48f, 49f));
const iamfpmaimaf = array(mat2x2(42, 43, 44, 45), mat2x2(46.0, 47.0, 48.0, 49.0));
const iamfpmaimai = array(mat2x2(42, 43, 44, 45), mat2x2(46, 47, 48, 49));
const iamfpmaimf = array(mat2x2(42, 43, 44, 45), mat2x2(46f, 47f, 48f, 49f));
const iamfpmfmaf = array(mat2x2(42f, 43f, 44f, 45f), mat2x2(46.0, 47.0, 48.0, 49.0));
const iamfpmfmai = array(mat2x2(42f, 43f, 44f, 45f), mat2x2(46, 47, 48, 49));
const iamfpmfmf = array(mat2x2(42f, 43f, 44f, 45f), mat2x2(46f, 47f, 48f, 49f));

const iau = array<u32, 2>();
const iau__u_u = array<u32, 2>(42u, 43u);
const iau__uai = array<u32, 2>(42u, 43);
const iau_ai_u = array<u32, 2>(42, 43u);
const iau_aiai = array<u32, 2>(42, 43);
const iaup_u_u = array(42u, 43u);
const iaup_uai = array(42u, 43);
const iaupai_u = array(42, 43u);
const iaupaiai = array(42, 43);

const iavf = array<vec2<f32>, 2>();
const iavf_vafvaf = array<vec2<f32>, 2>(vec2(42.0, 43.0), vec2(44.0, 45.0));
const iavf_vafvai = array<vec2<f32>, 2>(vec2(42.0, 43.0), vec2(44, 45));
const iavf_vafvf = array<vec2<f32>, 2>(vec2(42.0, 43.0), vec2(44f, 45f));
const iavf_vaivaf = array<vec2<f32>, 2>(vec2(42, 43), vec2(44.0, 45.0));
const iavf_vaivai = array<vec2<f32>, 2>(vec2(42, 43), vec2(44, 45));
const iavf_vaivf = array<vec2<f32>, 2>(vec2(42, 43), vec2(44f, 45f));
const iavf_vfvaf = array<vec2<f32>, 2>(vec2(42f, 43f), vec2(44.0, 45.0));
const iavf_vfvai = array<vec2<f32>, 2>(vec2(42f, 43f), vec2(44, 45));
const iavf_vfvf = array<vec2<f32>, 2>(vec2(42f, 43f), vec2(44f, 45f));
const iavfpvafvaf = array(vec2(42.0, 43.0), vec2(44.0, 45.0));
const iavfpvafvai = array(vec2(42.0, 43.0), vec2(44, 45));
const iavfpvafvf = array(vec2(42.0, 43.0), vec2(44f, 45f));
const iavfpvaivaf = array(vec2(42, 43), vec2(44.0, 45.0));
const iavfpvaivai = array(vec2(42, 43), vec2(44, 45));
const iavfpvaivf = array(vec2(42, 43), vec2(44f, 45f));
const iavfpvfvaf = array(vec2(42f, 43f), vec2(44.0, 45.0));
const iavfpvfvai = array(vec2(42f, 43f), vec2(44, 45));
const iavfpvfvf = array(vec2(42f, 43f), vec2(44f, 45f));

const iavi = array<vec2<i32>, 2>();
const iavi_vaivai = array<vec2<i32>, 2>(vec2(42, 43), vec2(44, 45));
const iavi_vaivi = array<vec2<i32>, 2>(vec2(42, 43), vec2(44i, 45i));
const iavi_vivai = array<vec2<i32>, 2>(vec2(42i, 43i), vec2(44, 45));
const iavi_vivi = array<vec2<i32>, 2>(vec2(42i, 43i), vec2(44i, 45i));
const iavipvaivai = array(vec2(42, 43), vec2(44, 45));
const iavipvaivi = array(vec2(42, 43), vec2(44i, 45i));
const iavipvivai = array(vec2(42i, 43i), vec2(44, 45));
const iavipvivi = array(vec2(42i, 43i), vec2(44i, 45i));

const iavu = array<vec2<u32>, 2>();
const iavu_vaivai = array<vec2<u32>, 2>(vec2(42, 43), vec2(44, 45));
const iavu_vaivu = array<vec2<u32>, 2>(vec2(42, 43), vec2(44u, 45u));
const iavu_vuvai = array<vec2<u32>, 2>(vec2(42u, 43u), vec2(44, 45));
const iavu_vuvu = array<vec2<u32>, 2>(vec2(42u, 43u), vec2(44u, 45u));
const iavupvaivai = array(vec2(42, 43), vec2(44, 45));
const iavupvaivu = array(vec2(42, 43), vec2(44u, 45u));
const iavupvuvai = array(vec2(42u, 43u), vec2(44, 45));
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
const imf__fafafaf = mat2x2<f32>(42f, 43.0, 44.0, 45.0);
const imf__faiaiai = mat2x2<f32>(42f, 43, 44, 45);
const imf_af_fafaf = mat2x2<f32>(42.0, 43f, 44.0, 45.0);
const imf_afaf_faf = mat2x2<f32>(42.0, 43.0, 44f, 45.0);
const imf_afafaf_f = mat2x2<f32>(42.0, 43.0, 44.0, 45f);
const imf_afafafaf = mat2x2<f32>(42.0, 43.0, 44.0, 45.0);
const imf_afaiaiai = mat2x2<f32>(42.0, 43, 44, 45);
const imf_ai_faiai = mat2x2<f32>(42, 43f, 44, 45);
const imf_aiafaiai = mat2x2<f32>(42, 43.0, 44, 45);
const imf_aiai_fai = mat2x2<f32>(42, 43, 44f, 45);
const imf_aiaiafai = mat2x2<f32>(42, 43, 44.0, 45);
const imf_aiaiai_f = mat2x2<f32>(42, 43, 44, 45f);
const imf_aiaiaiaf = mat2x2<f32>(42, 43, 44, 45.0);
const imf_aiaiaiai = mat2x2<f32>(42, 43, 44, 45);
const imfp_f_f_f_f = mat2x2(42f, 43f, 44f, 45f);
const imfp_fafafaf = mat2x2(42f, 43.0, 44.0, 45.0);
const imfp_faiaiai = mat2x2(42f, 43, 44, 45);
const imfpaf_fafaf = mat2x2(42.0, 43f, 44.0, 45.0);
const imfpafaf_faf = mat2x2(42.0, 43.0, 44f, 45.0);
const imfpafafaf_f = mat2x2(42.0, 43.0, 44.0, 45f);
const imfpafafafaf = mat2x2(42.0, 43.0, 44.0, 45.0);
const imfpafaiaiai = mat2x2(42.0, 43, 44, 45);
const imfpai_faiai = mat2x2(42, 43f, 44, 45);
const imfpaiafaiai = mat2x2(42, 43.0, 44, 45);
const imfpaiai_fai = mat2x2(42, 43, 44f, 45);
const imfpaiaiafai = mat2x2(42, 43, 44.0, 45);
const imfpaiaiai_f = mat2x2(42, 43, 44, 45f);
const imfpaiaiaiaf = mat2x2(42, 43, 44, 45.0);
const imfpaiaiaiai = mat2x2(42, 43, 44, 45);

const iu = u32();
const iu_sai = u32(42);
const iu_su = u32(42u);
const iupsai = 42;
const iupsu = 42u;

const ivf = vec2<f32>();
const ivf__f_f = vec2<f32>(42f, 43f);
const ivf__faf = vec2<f32>(42f, 43.0);
const ivf__fai = vec2<f32>(42f, 43);
const ivf_af_f = vec2<f32>(42.0, 43f);
const ivf_afaf = vec2<f32>(42.0, 43.0);
const ivf_afai = vec2<f32>(42.0, 43);
const ivf_ai_f = vec2<f32>(42, 43f);
const ivf_aiaf = vec2<f32>(42, 43.0);
const ivf_aiai = vec2<f32>(42, 43);
const ivf_saf = vec2<f32>(42.0);
const ivf_sai = vec2<f32>(42);
const ivf_sf = vec2<f32>(42f);
const ivfp_f_f = vec2(42f, 43f);
const ivfp_faf = vec2(42f, 43.0);
const ivfp_fai = vec2(42f, 43);
const ivfpaf_f = vec2(42.0, 43f);
const ivfpafaf = vec2(42.0, 43.0);
const ivfpafai = vec2(42.0, 43);
const ivfpai_f = vec2(42, 43f);
const ivfpaiaf = vec2(42, 43.0);
const ivfpaiai = vec2(42, 43);
const ivfpsaf = vec2(42.0);
const ivfpsai = vec2(42);
const ivfpsf = vec2(42f);

const ivi = vec2<i32>();
const ivi__i_i = vec2<i32>(42i, 43i);
const ivi__iai = vec2<i32>(42i, 43);
const ivi_ai_i = vec2<i32>(42, 43i);
const ivi_aiai = vec2<i32>(42, 43);
const ivi_sai = vec2<i32>(42);
const ivi_si = vec2<i32>(42i);
const ivip_i_i = vec2(42i, 43i);
const ivip_iai = vec2(42i, 43);
const ivipai_i = vec2(42, 43i);
const ivipaiai = vec2(42, 43);
const ivipsai = vec2(42);
const ivipsi = vec2(42i);

const ivu = vec2<u32>();
const ivu__u_u = vec2<u32>(42u, 43u);
const ivu__uai = vec2<u32>(42u, 43);
const ivu_ai_u = vec2<u32>(42, 43u);
const ivu_aiai = vec2<u32>(42, 43);
const ivu_sai = vec2<u32>(42);
const ivu_su = vec2<u32>(42u);
const ivup_u_u = vec2(42u, 43u);
const ivup_uai = vec2(42u, 43);
const ivupai_u = vec2(42, 43u);
const ivupaiai = vec2(42, 43);
const ivupsai = vec2(42);
const ivupsu = vec2(42u);

const not_keyword_if = f32();

const xaf: array<f32, 2> = array<f32, 2>();
const xaf__f_f: array<f32, 2> = array<f32, 2>(42f, 43f);
const xaf__faf: array<f32, 2> = array<f32, 2>(42f, 43.0);
const xaf__fai: array<f32, 2> = array<f32, 2>(42f, 43);
const xaf_af_f: array<f32, 2> = array<f32, 2>(42.0, 43f);
const xaf_afaf: array<f32, 2> = array<f32, 2>(42.0, 43.0);
const xaf_afai: array<f32, 2> = array<f32, 2>(42.0, 43);
const xaf_ai_f: array<f32, 2> = array<f32, 2>(42, 43f);
const xaf_aiaf: array<f32, 2> = array<f32, 2>(42, 43.0);
const xaf_aiai: array<f32, 2> = array<f32, 2>(42, 43);
const xafp_f_f: array<f32, 2> = array(42f, 43f);
const xafp_faf: array<f32, 2> = array(42f, 43.0);
const xafp_fai: array<f32, 2> = array(42f, 43);
const xafpaf_f: array<f32, 2> = array(42.0, 43f);
const xafpafaf: array<f32, 2> = array(42.0, 43.0);
const xafpafai: array<f32, 2> = array(42.0, 43);
const xafpai_f: array<f32, 2> = array(42, 43f);
const xafpaiaf: array<f32, 2> = array(42, 43.0);
const xafpaiai: array<f32, 2> = array(42, 43);

const xai: array<i32, 2> = array<i32, 2>();
const xai__i_i: array<i32, 2> = array<i32, 2>(42i, 43i);
const xai__iai: array<i32, 2> = array<i32, 2>(42i, 43);
const xai_ai_i: array<i32, 2> = array<i32, 2>(42, 43i);
const xai_aiai: array<i32, 2> = array<i32, 2>(42, 43);
const xaip_i_i: array<i32, 2> = array(42i, 43i);
const xaip_iai: array<i32, 2> = array(42i, 43);
const xaipai_i: array<i32, 2> = array(42, 43i);
const xaipaiai: array<i32, 2> = array(42, 43);

const xamf: array<mat2x2<f32>, 2> = array<mat2x2<f32>, 2>();
const xamf_mafmaf: array<mat2x2<f32>, 2> = array<mat2x2<f32>, 2>(mat2x2(42.0, 43.0, 44.0, 45.0), mat2x2(46.0, 47.0, 48.0, 49.0));
const xamf_mafmai: array<mat2x2<f32>, 2> = array<mat2x2<f32>, 2>(mat2x2(42.0, 43.0, 44.0, 45.0), mat2x2(46, 47, 48, 49));
const xamf_mafmf: array<mat2x2<f32>, 2> = array<mat2x2<f32>, 2>(mat2x2(42.0, 43.0, 44.0, 45.0), mat2x2(46f, 47f, 48f, 49f));
const xamf_maimaf: array<mat2x2<f32>, 2> = array<mat2x2<f32>, 2>(mat2x2(42, 43, 44, 45), mat2x2(46.0, 47.0, 48.0, 49.0));
const xamf_maimai: array<mat2x2<f32>, 2> = array<mat2x2<f32>, 2>(mat2x2(42, 43, 44, 45), mat2x2(46, 47, 48, 49));
const xamf_maimf: array<mat2x2<f32>, 2> = array<mat2x2<f32>, 2>(mat2x2(42, 43, 44, 45), mat2x2(46f, 47f, 48f, 49f));
const xamf_mfmaf: array<mat2x2<f32>, 2> = array<mat2x2<f32>, 2>(mat2x2(42f, 43f, 44f, 45f), mat2x2(46.0, 47.0, 48.0, 49.0));
const xamf_mfmai: array<mat2x2<f32>, 2> = array<mat2x2<f32>, 2>(mat2x2(42f, 43f, 44f, 45f), mat2x2(46, 47, 48, 49));
const xamf_mfmf: array<mat2x2<f32>, 2> = array<mat2x2<f32>, 2>(mat2x2(42f, 43f, 44f, 45f), mat2x2(46f, 47f, 48f, 49f));
const xamfpmafmaf: array<mat2x2<f32>, 2> = array(mat2x2(42.0, 43.0, 44.0, 45.0), mat2x2(46.0, 47.0, 48.0, 49.0));
const xamfpmafmai: array<mat2x2<f32>, 2> = array(mat2x2(42.0, 43.0, 44.0, 45.0), mat2x2(46, 47, 48, 49));
const xamfpmafmf: array<mat2x2<f32>, 2> = array(mat2x2(42.0, 43.0, 44.0, 45.0), mat2x2(46f, 47f, 48f, 49f));
const xamfpmaimaf: array<mat2x2<f32>, 2> = array(mat2x2(42, 43, 44, 45), mat2x2(46.0, 47.0, 48.0, 49.0));
const xamfpmaimai: array<mat2x2<f32>, 2> = array(mat2x2(42, 43, 44, 45), mat2x2(46, 47, 48, 49));
const xamfpmaimf: array<mat2x2<f32>, 2> = array(mat2x2(42, 43, 44, 45), mat2x2(46f, 47f, 48f, 49f));
const xamfpmfmaf: array<mat2x2<f32>, 2> = array(mat2x2(42f, 43f, 44f, 45f), mat2x2(46.0, 47.0, 48.0, 49.0));
const xamfpmfmai: array<mat2x2<f32>, 2> = array(mat2x2(42f, 43f, 44f, 45f), mat2x2(46, 47, 48, 49));
const xamfpmfmf: array<mat2x2<f32>, 2> = array(mat2x2(42f, 43f, 44f, 45f), mat2x2(46f, 47f, 48f, 49f));

const xau: array<u32, 2> = array<u32, 2>();
const xau__u_u: array<u32, 2> = array<u32, 2>(42u, 43u);
const xau__uai: array<u32, 2> = array<u32, 2>(42u, 43);
const xau_ai_u: array<u32, 2> = array<u32, 2>(42, 43u);
const xau_aiai: array<u32, 2> = array<u32, 2>(42, 43);
const xaup_u_u: array<u32, 2> = array(42u, 43u);
const xaup_uai: array<u32, 2> = array(42u, 43);
const xaupai_u: array<u32, 2> = array(42, 43u);
const xaupaiai: array<u32, 2> = array(42, 43);

const xavf: array<vec2<f32>, 2> = array<vec2<f32>, 2>();
const xavf_vafvaf: array<vec2<f32>, 2> = array<vec2<f32>, 2>(vec2(42.0, 43.0), vec2(44.0, 45.0));
const xavf_vafvai: array<vec2<f32>, 2> = array<vec2<f32>, 2>(vec2(42.0, 43.0), vec2(44, 45));
const xavf_vafvf: array<vec2<f32>, 2> = array<vec2<f32>, 2>(vec2(42.0, 43.0), vec2(44f, 45f));
const xavf_vaivaf: array<vec2<f32>, 2> = array<vec2<f32>, 2>(vec2(42, 43), vec2(44.0, 45.0));
const xavf_vaivai: array<vec2<f32>, 2> = array<vec2<f32>, 2>(vec2(42, 43), vec2(44, 45));
const xavf_vaivf: array<vec2<f32>, 2> = array<vec2<f32>, 2>(vec2(42, 43), vec2(44f, 45f));
const xavf_vfvaf: array<vec2<f32>, 2> = array<vec2<f32>, 2>(vec2(42f, 43f), vec2(44.0, 45.0));
const xavf_vfvai: array<vec2<f32>, 2> = array<vec2<f32>, 2>(vec2(42f, 43f), vec2(44, 45));
const xavf_vfvf: array<vec2<f32>, 2> = array<vec2<f32>, 2>(vec2(42f, 43f), vec2(44f, 45f));
const xavfpvafvaf: array<vec2<f32>, 2> = array(vec2(42.0, 43.0), vec2(44.0, 45.0));
const xavfpvafvai: array<vec2<f32>, 2> = array(vec2(42.0, 43.0), vec2(44, 45));
const xavfpvafvf: array<vec2<f32>, 2> = array(vec2(42.0, 43.0), vec2(44f, 45f));
const xavfpvaivaf: array<vec2<f32>, 2> = array(vec2(42, 43), vec2(44.0, 45.0));
const xavfpvaivai: array<vec2<f32>, 2> = array(vec2(42, 43), vec2(44, 45));
const xavfpvaivf: array<vec2<f32>, 2> = array(vec2(42, 43), vec2(44f, 45f));
const xavfpvfvaf: array<vec2<f32>, 2> = array(vec2(42f, 43f), vec2(44.0, 45.0));
const xavfpvfvai: array<vec2<f32>, 2> = array(vec2(42f, 43f), vec2(44, 45));
const xavfpvfvf: array<vec2<f32>, 2> = array(vec2(42f, 43f), vec2(44f, 45f));

const xavi: array<vec2<i32>, 2> = array<vec2<i32>, 2>();
const xavi_vaivai: array<vec2<i32>, 2> = array<vec2<i32>, 2>(vec2(42, 43), vec2(44, 45));
const xavi_vaivi: array<vec2<i32>, 2> = array<vec2<i32>, 2>(vec2(42, 43), vec2(44i, 45i));
const xavi_vivai: array<vec2<i32>, 2> = array<vec2<i32>, 2>(vec2(42i, 43i), vec2(44, 45));
const xavi_vivi: array<vec2<i32>, 2> = array<vec2<i32>, 2>(vec2(42i, 43i), vec2(44i, 45i));
const xavipvaivai: array<vec2<i32>, 2> = array(vec2(42, 43), vec2(44, 45));
const xavipvaivi: array<vec2<i32>, 2> = array(vec2(42, 43), vec2(44i, 45i));
const xavipvivai: array<vec2<i32>, 2> = array(vec2(42i, 43i), vec2(44, 45));
const xavipvivi: array<vec2<i32>, 2> = array(vec2(42i, 43i), vec2(44i, 45i));

const xavu: array<vec2<u32>, 2> = array<vec2<u32>, 2>();
const xavu_vaivai: array<vec2<u32>, 2> = array<vec2<u32>, 2>(vec2(42, 43), vec2(44, 45));
const xavu_vaivu: array<vec2<u32>, 2> = array<vec2<u32>, 2>(vec2(42, 43), vec2(44u, 45u));
const xavu_vuvai: array<vec2<u32>, 2> = array<vec2<u32>, 2>(vec2(42u, 43u), vec2(44, 45));
const xavu_vuvu: array<vec2<u32>, 2> = array<vec2<u32>, 2>(vec2(42u, 43u), vec2(44u, 45u));
const xavupvaivai: array<vec2<u32>, 2> = array(vec2(42, 43), vec2(44, 45));
const xavupvaivu: array<vec2<u32>, 2> = array(vec2(42, 43), vec2(44u, 45u));
const xavupvuvai: array<vec2<u32>, 2> = array(vec2(42u, 43u), vec2(44, 45));
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
const xmf__fafafaf: mat2x2<f32> = mat2x2<f32>(42f, 43.0, 44.0, 45.0);
const xmf__faiaiai: mat2x2<f32> = mat2x2<f32>(42f, 43, 44, 45);
const xmf_af_fafaf: mat2x2<f32> = mat2x2<f32>(42.0, 43f, 44.0, 45.0);
const xmf_afaf_faf: mat2x2<f32> = mat2x2<f32>(42.0, 43.0, 44f, 45.0);
const xmf_afafaf_f: mat2x2<f32> = mat2x2<f32>(42.0, 43.0, 44.0, 45f);
const xmf_afafafaf: mat2x2<f32> = mat2x2<f32>(42.0, 43.0, 44.0, 45.0);
const xmf_afaiaiai: mat2x2<f32> = mat2x2<f32>(42.0, 43, 44, 45);
const xmf_ai_faiai: mat2x2<f32> = mat2x2<f32>(42, 43f, 44, 45);
const xmf_aiafaiai: mat2x2<f32> = mat2x2<f32>(42, 43.0, 44, 45);
const xmf_aiai_fai: mat2x2<f32> = mat2x2<f32>(42, 43, 44f, 45);
const xmf_aiaiafai: mat2x2<f32> = mat2x2<f32>(42, 43, 44.0, 45);
const xmf_aiaiai_f: mat2x2<f32> = mat2x2<f32>(42, 43, 44, 45f);
const xmf_aiaiaiaf: mat2x2<f32> = mat2x2<f32>(42, 43, 44, 45.0);
const xmf_aiaiaiai: mat2x2<f32> = mat2x2<f32>(42, 43, 44, 45);
const xmfp_f_f_f_f: mat2x2<f32> = mat2x2(42f, 43f, 44f, 45f);
const xmfp_fafafaf: mat2x2<f32> = mat2x2(42f, 43.0, 44.0, 45.0);
const xmfp_faiaiai: mat2x2<f32> = mat2x2(42f, 43, 44, 45);
const xmfpaf_fafaf: mat2x2<f32> = mat2x2(42.0, 43f, 44.0, 45.0);
const xmfpafaf_faf: mat2x2<f32> = mat2x2(42.0, 43.0, 44f, 45.0);
const xmfpafafaf_f: mat2x2<f32> = mat2x2(42.0, 43.0, 44.0, 45f);
const xmfpafafafaf: mat2x2<f32> = mat2x2(42.0, 43.0, 44.0, 45.0);
const xmfpafaiaiai: mat2x2<f32> = mat2x2(42.0, 43, 44, 45);
const xmfpai_faiai: mat2x2<f32> = mat2x2(42, 43f, 44, 45);
const xmfpaiafaiai: mat2x2<f32> = mat2x2(42, 43.0, 44, 45);
const xmfpaiai_fai: mat2x2<f32> = mat2x2(42, 43, 44f, 45);
const xmfpaiaiafai: mat2x2<f32> = mat2x2(42, 43, 44.0, 45);
const xmfpaiaiai_f: mat2x2<f32> = mat2x2(42, 43, 44, 45f);
const xmfpaiaiaiaf: mat2x2<f32> = mat2x2(42, 43, 44, 45.0);
const xmfpaiaiaiai: mat2x2<f32> = mat2x2(42, 43, 44, 45);

const xu: u32 = u32();
const xu_sai: u32 = u32(42);
const xu_su: u32 = u32(42u);
const xupsai: u32 = 42;
const xupsu: u32 = 42u;

const xvf: vec2<f32> = vec2<f32>();
const xvf__f_f: vec2<f32> = vec2<f32>(42f, 43f);
const xvf__faf: vec2<f32> = vec2<f32>(42f, 43.0);
const xvf__fai: vec2<f32> = vec2<f32>(42f, 43);
const xvf_af_f: vec2<f32> = vec2<f32>(42.0, 43f);
const xvf_afaf: vec2<f32> = vec2<f32>(42.0, 43.0);
const xvf_afai: vec2<f32> = vec2<f32>(42.0, 43);
const xvf_ai_f: vec2<f32> = vec2<f32>(42, 43f);
const xvf_aiaf: vec2<f32> = vec2<f32>(42, 43.0);
const xvf_aiai: vec2<f32> = vec2<f32>(42, 43);
const xvf_saf: vec2<f32> = vec2<f32>(42.0);
const xvf_sai: vec2<f32> = vec2<f32>(42);
const xvf_sf: vec2<f32> = vec2<f32>(42f);
const xvfp_f_f: vec2<f32> = vec2(42f, 43f);
const xvfp_faf: vec2<f32> = vec2(42f, 43.0);
const xvfp_fai: vec2<f32> = vec2(42f, 43);
const xvfpaf_f: vec2<f32> = vec2(42.0, 43f);
const xvfpafaf: vec2<f32> = vec2(42.0, 43.0);
const xvfpafai: vec2<f32> = vec2(42.0, 43);
const xvfpai_f: vec2<f32> = vec2(42, 43f);
const xvfpaiaf: vec2<f32> = vec2(42, 43.0);
const xvfpaiai: vec2<f32> = vec2(42, 43);
const xvfpsaf: vec2<f32> = vec2(42.0);
const xvfpsai: vec2<f32> = vec2(42);
const xvfpsf: vec2<f32> = vec2(42f);

const xvi: vec2<i32> = vec2<i32>();
const xvi__i_i: vec2<i32> = vec2<i32>(42i, 43i);
const xvi__iai: vec2<i32> = vec2<i32>(42i, 43);
const xvi_ai_i: vec2<i32> = vec2<i32>(42, 43i);
const xvi_aiai: vec2<i32> = vec2<i32>(42, 43);
const xvi_sai: vec2<i32> = vec2<i32>(42);
const xvi_si: vec2<i32> = vec2<i32>(42i);
const xvip_i_i: vec2<i32> = vec2(42i, 43i);
const xvip_iai: vec2<i32> = vec2(42i, 43);
const xvipai_i: vec2<i32> = vec2(42, 43i);
const xvipaiai: vec2<i32> = vec2(42, 43);
const xvipsai: vec2<i32> = vec2(42);
const xvipsi: vec2<i32> = vec2(42i);

const xvu: vec2<u32> = vec2<u32>();
const xvu__u_u: vec2<u32> = vec2<u32>(42u, 43u);
const xvu__uai: vec2<u32> = vec2<u32>(42u, 43);
const xvu_ai_u: vec2<u32> = vec2<u32>(42, 43u);
const xvu_aiai: vec2<u32> = vec2<u32>(42, 43);
const xvu_sai: vec2<u32> = vec2<u32>(42);
const xvu_su: vec2<u32> = vec2<u32>(42u);
const xvup_u_u: vec2<u32> = vec2(42u, 43u);
const xvup_uai: vec2<u32> = vec2(42u, 43);
const xvupai_u: vec2<u32> = vec2(42, 43u);
const xvupaiai: vec2<u32> = vec2(42, 43);
const xvupsai: vec2<u32> = vec2(42);
const xvupsu: vec2<u32> = vec2(42u);
