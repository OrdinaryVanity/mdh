vec4 Process(vec4 color)
{
    vec3 eyedir = normalize(uCameraPos.xyz - pixelpos.xyz);
    vec3 norm = reflect(eyedir, normalize(vWorldNormal.xyz));
    return getTexel(norm.xz * 0.5) * color;
}

