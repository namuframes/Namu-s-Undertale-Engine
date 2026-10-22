attribute vec3 in_Position;        // block origin (x, y)
attribute vec2 in_TextureCoord;    // quad corner (0/1)
attribute vec4 in_TextureCoord1;   // velx, vely0, smh0, index

varying vec2 v_uv;
varying float v_alpha;

uniform float u_time, u_size, u_spd;
uniform float u_alphaLoss, u_velyAdd, u_rise, u_smhLerp, u_sizeLoss;
uniform vec2  u_origin, u_surfSize;

void main()
{
    float velx = in_TextureCoord1.x, vely0 = in_TextureCoord1.y;
    float smh0 = in_TextureCoord1.z, idx = in_TextureCoord1.w;

    // steps since this block activated (peee >= i)
    float n = max(u_time - ceil((idx - 1.0) / u_spd), 0.0);
    float r = 1.0 - u_smhLerp;

    float alpha   = 1.0 - u_alphaLoss * n;                                   // alpha -= alpha_loss
    float offsize = -u_sizeLoss * n;                                         // offsize -= .01
    float offx = velx * smh0 * r * (1.0 - pow(r, n)) / max(u_smhLerp, 0.0001); // smh=lerp(smh,0,.1); offx+=velx*smh
    float offy = -u_rise * (n * vely0 + 0.5 * u_velyAdd * n * (n + 1.0));    // vely+=.5; offy-=vely*.1

    float s = u_size + offsize;
    vec2 local = in_TextureCoord * s;
    vec2 pos = u_origin + in_Position.xy + vec2(offx, offy) + local;
    gl_Position = gm_Matrices[MATRIX_WORLD_VIEW_PROJECTION] * vec4(pos, 0.0, 1.0);

    // particle "deleted"
    if (alpha <= 0.0 || offsize <= -u_size) gl_Position = vec4(2.0, 2.0, 2.0, 1.0);

    v_uv = (in_Position.xy + local) / u_surfSize;
    v_alpha = clamp(alpha, 0.0, 1.0);
}