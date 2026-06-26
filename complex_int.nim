include math

type
    ## Generic bit‑packed complex integer.
    ## Underlying storage is exactly the size of T (int8/int16/int32/int64).
    ## High half of bits = imaginary component.
    ## Low half of bits  = real component.
    cpx*[T: SomeInteger] = distinct T


template half_bits(T: typedesc): int =
    ## Number of bits per component.
    ## Each cpx[T] splits the underlying integer into two equal halves.
    sizeof(T) * 4


proc decode_n(x: int; bits: int): int =
    ## Decode a signed N‑bit integer from the low bits of x.
    ## Performs sign‑extension for values >= 2^(bits‑1).
    let mask = (1 shl bits) - 1
    let v = x and mask
    if v >= (1 shl (bits - 1)): v - (1 shl bits) else: v


proc encode_n(x: int; bits: int): int =
    ## Encode an integer into N bits (wraps/truncates to fit).
    x and ((1 shl bits) - 1)


proc re*[T: SomeInteger](z: cpx[T]): int =
    ## Extract the real component from the low half of the packed integer.
    let bits = half_bits(T)
    decode_n(int(z) and ((1 shl bits) - 1), bits)


proc im*[T: SomeInteger](z: cpx[T]): int =
    ## Extract the imaginary component from the high half of the packed integer.
    let bits = half_bits(T)
    decode_n((int(z) shr bits), bits)


proc make_cpx*[T: SomeInteger](re, im: int): cpx[T] =
    ## Construct a packed complex value from integer real/imag parts.
    ## Each part is encoded into half‑width signed fields.
    let bits = half_bits(T)
    let raw = (encode_n(im, bits) shl bits) or encode_n(re, bits)
    cast[cpx[T]](raw)


proc `+`*[T: SomeInteger](a, b: cpx[T]): cpx[T] =
    ## Component‑wise addition (wraps on overflow).
    make_cpx[T](a.re + b.re, a.im + b.im)


proc `-`*[T: SomeInteger](a, b: cpx[T]): cpx[T] =
    ## Component‑wise subtraction (wraps on overflow).
    make_cpx[T](a.re - b.re, a.im - b.im)


proc `*`*[T: SomeInteger](a, b: cpx[T]): cpx[T] =
    ## Complex multiplication:
    ## (ar + ai*i) * (br + bi*i) = (ar*br - ai*bi) + (ar*bi + ai*br)*i
    let
        ar = a.re
        ai = a.im
        br = b.re
        bi = b.im
    make_cpx[T](ar*br - ai*bi, ar*bi + ai*br)


proc `/`*[T: SomeInteger](a, b: cpx[T]): cpx[T] =
    ## Complex division using integer arithmetic.
    ## Result is truncated toward zero.
    let denom = b.re*b.re + b.im*b.im
    make_cpx[T](
        (a.re*b.re + a.im*b.im) div denom,
        (a.im*b.re - a.re*b.im) div denom
    )


proc `-`*[T: SomeInteger](a: cpx[T]): cpx[T] =
    ## Unary negation: flips both components.
    make_cpx[T](-a.re, -a.im)


proc `==`*[T: SomeInteger](a, b: cpx[T]): bool =
    ## Component‑wise equality.
    a.re == b.re and a.im == b.im


proc conj*[T: SomeInteger](z: cpx[T]): cpx[T] =
    ## Complex conjugate: (re, im) → (re, -im).
    make_cpx[T](z.re, -z.im)


proc mag2*[T: SomeInteger](z: cpx[T]): int =
    ## Squared magnitude: re^2 + im^2.
    ## Avoids sqrt; useful for comparisons.
    z.re*z.re + z.im*z.im


proc mag*[T: SomeInteger](z: cpx[T]): float =
    ## Magnitude (Euclidean length).
    sqrt(float(z.re*z.re + z.im*z.im))


proc dot*[T: SomeInteger](a, b: cpx[T]): int =
    ## Dot product of two complex numbers treated as 2D vectors.
    a.re*b.re + a.im*b.im


proc hadamard*[T: SomeInteger](a, b: cpx[T]): cpx[T] =
    ## Component‑wise multiplication (Hadamard product).
    make_cpx[T](a.re*b.re, a.im*b.im)


proc angle*[T: SomeInteger](z: cpx[T]): float =
    ## Phase angle (argument) in radians.
    arctan2(z.im.float, z.re.float)


proc dist*[T: SomeInteger](a, b: cpx[T]): float =
    ## Euclidean distance between two complex values.
    (a - b).mag


proc `$`*[T: SomeInteger](z: cpx[T]): string =
    ## Human‑readable representation: "(re + im i)".
    "(" & $z.re & " + " & $z.im & "i)"


type
    ## Concrete bit‑packed complex types.
    ## cpx8  → 4‑bit real + 4‑bit imag
    ## cpx16 → 8‑bit real + 8‑bit imag
    ## cpx32 → 16‑bit real + 16‑bit imag
    ## cpx64 → 32‑bit real + 32‑bit imag
    cpx8*  = cpx[int8]
    cpx16* = cpx[int16]
    cpx32* = cpx[int32]
    cpx64* = cpx[int64]
