## **(Hyper)complex Numeric Library for Nim**  
A modular, extensible numeric library providing **complex** and **hypercomplex** number systems for Nim.  
Designed for clarity, performance, and future expansion.

This library is structured so users can import **only the numeric systems they need**, while leaving room for additional backends and higher‑dimensional algebras.

---

## **Modules Overview**

### **Available Now**
#### **`complex_int.nim`**  
Integer‑based complex numbers using **bit‑packed fixed‑width storage**.  
Each complex value is stored in a single integer type (`int8`, `int16`, `int32`, `int64`), with half the bits used for the real part and half for the imaginary part.

- deterministic overflow behavior  
- compact representation  
- ideal for DSP, embedded systems, and fixed‑point math  
- supports all standard complex operations (add, sub, mul, div, conj, magnitude, dot, angle, etc.)

---

### **Planned Modules**
These modules will follow the same API shape as `complex_int`, but with different numeric backends or dimensionality.

#### **`complex_float.nim`**  
Floating‑point complex numbers using `float32` or `float64`.

#### **`hypr4_cpx_int.nim`** (Quaternions, integer backend)  
4‑component hypercomplex numbers (quaternions) stored using integer types.

#### **`hypr4_cpx_float.nim`** (Quaternions, float backend)  
Floating‑point quaternion implementation for 3D graphics, physics, and robotics.

#### **`hypr8_cpx_int.nim`** (Octonions, integer backend)  
8‑component hypercomplex numbers using integer storage.

#### **`hypr8_cpx_float.nim`** (Octonions, float backend)  
Floating‑point octonions for advanced mathematical applications.

---

## **Design Philosophy**

### **Modular**
Each numeric family lives in its own module.  
Users import only what they need:

```nim
import complex_int
import complex_float
import hypr4_cpx_float
```

### **Extensible**
The library is designed to grow into a full hypercomplex ecosystem:

- complex numbers (2D)
- quaternions (4D)
- octonions (8D)
- sedenions (16D)
- trigintaduonions (32D)
- and beyond

Each dimension can support both integer and float backends.

### **Consistent API**
All modules follow the same naming and operator conventions:

- `+`, `-`, `*`, `/`
- `conj`
- `mag`, `mag2`
- `dot`, `hadamard`
- `angle` (where applicable)
- `dist`
- `$` for string formatting

This makes switching between numeric systems seamless.

---

## ** Mathematical Background**

This library implements several well‑known algebraic systems.  
For users unfamiliar with them, here are helpful references:

- **Complex Numbers (2D)**  
  `https://en.wikipedia.org/wiki/Complex_number`

- **Quaternions (4D)**  
  `https://en.wikipedia.org/wiki/Quaternion`

- **Octonions (8D)**  
  `https://en.wikipedia.org/wiki/Octonion`

These systems are part of the **Cayley–Dickson construction**, a method for generating higher‑dimensional algebras.

---

## **🛠 Example Usage**

```nim
import complex_int

let a: cpx8 = make_cpx[int8](3, -2)
let b: cpx8 = make_cpx[int8](1, 5)

echo a + b
echo a * b
echo a.mag
echo a.angle
```

Future modules will follow the same pattern.

---

## **Future Plans**
- `complex_float.nim`
- quaternion modules (int + float)
- octonion modules (int + float)
- Possible (no guarantee) sedenion modules (int + float)
