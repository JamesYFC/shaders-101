// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

Shader "Custom/Test5"
{
    Properties
    {
        _MainTex("Texture", 2D) = "white" {}
        _SecondTex("Second Texture", 2D) = "white" {}
        _InterpolateVal("Interpolate", Range(0, 1)) = 0
    }
    SubShader
    {
        Tags
        {
            "Queue" = "Transparent"
        }
        Pass
        {
            Blend SrcAlpha OneMinusSrcAlpha
            
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag

            #include "UnityCG.cginc"

            struct appdata
            {
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0;
            };

            struct v2f
            {
                float4 vertex : SV_POSITION;
                float2 uv : TEXCOORD0;
            };

            v2f vert(appdata v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv = v.uv;
                return o;
            }

            sampler2D _MainTex;
            sampler2D _SecondTex;
            float _InterpolateVal;

            float4 frag(v2f i) : SV_Target
            {
                float4 tex1 = tex2D(_MainTex, i.uv) * (1 - _InterpolateVal);
                float4 tex2 = tex2D(_SecondTex, i.uv) * (_InterpolateVal);
                return tex1 + tex2;
            }
            ENDCG
        }
    }
}
