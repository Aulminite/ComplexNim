# Test suite for complex_int.nim
# Exercises construction, accessors, operators, and math utilities.

import complex_int

proc printHeader(title: string) =
    echo "\n=== ", title, " ==="

when isMainModule:

    printHeader("Construction and Accessors")

    let a: cpx8 = make_cpx[int8](3, -2)
    let b: cpx8 = make_cpx[int8](-1, 5)

    echo "a = ", a
    echo "b = ", b
    echo "a.re = ", a.re
    echo "a.im = ", a.im
    echo "b.re = ", b.re
    echo "b.im = ", b.im


    printHeader("Basic Arithmetic")

    echo "a + b = ", a + b
    echo "a - b = ", a - b
    echo "a * b = ", a * b
    echo "-a    = ", -a


    printHeader("Division")

    # Avoid division by zero
    let c: cpx8 = make_cpx[int8](2, 1)
    let d: cpx8 = make_cpx[int8](1, -1)

    echo "c = ", c
    echo "d = ", d
    echo "c / d = ", c / d


    printHeader("Conjugate")

    echo "conj(a) = ", conj(a)
    echo "conj(b) = ", conj(b)


    printHeader("Magnitude and Angle")

    echo "a.mag2 = ", a.mag2
    echo "a.mag  = ", a.mag
    echo "a.angle = ", a.angle
    echo "b.mag2 = ", b.mag2
    echo "b.mag  = ", b.mag
    echo "b.angle = ", b.angle


    printHeader("Dot and Hadamard Products")

    echo "dot(a, b) = ", dot(a, b)
    echo "hadamard(a, b) = ", hadamard(a, b)


    printHeader("Distance")

    echo "dist(a, b) = ", dist(a, b)


    printHeader("Larger Types (cpx16, cpx32, cpx64)")

    let x: cpx16 = make_cpx[int16](100, -200)
    let y: cpx16 = make_cpx[int16](-50, 75)

    echo "x = ", x
    echo "y = ", y
    echo "x + y = ", x + y
    echo "x * y = ", x * y
    echo "x.mag = ", x.mag
    echo "y.angle = ", y.angle

    printHeader("All tests completed.")
