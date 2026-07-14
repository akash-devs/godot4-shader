# Godot 4.7 Procedural 3D Shader Pack

An optimized, asset-free library of four completely math-driven procedural shaders built natively for **Godot 4.7**. 

Every material in this pack is 100% procedural—meaning **zero external textures or images are required**. They run flawlessly across all rendering backends, including **Compatibility mode**, making them incredibly performant for both high-end PC titles and low-end mobile hardware.

---

## 🔮 What's Inside

### 1. Solid Plasma Ball (`lightning.gdshader`)
* **How it works:** Uses a rapid 3D noise algorithm to trace electrical tracks across the surface. It includes a custom vertex jitter function that physically shakes the mesh vertices, making the sphere look wildly unstable.
* **Best use:** Sci-fi plasma weapons, power sources, or magical lightning spells.

### 2. Hologram Grid Core (`acid_shield.gdshader`)
* **How it works:** Projects a mathematical grid directly onto 3D space using intersecting sine waves. It features an automated breathing pulse animation that scales smoothly across the whole sphere.
* **Best use:** Sci-fi forcefields, target lock overlays, or futuristic UI elements.

### 3. Solid Lava Ball (`magma_core.gdshader`)
* **How it works:** Layers a slow-crawling fluid noise mask over a dense dark rocky base color. High-contrast threshold settings create sharp, glowing molten cracks that break through the surface crust naturally.
* **Best use:** Volcanic hazards, burning fireballs, or environmental set pieces.

### 4. Stylized Water Orb (`toon_water.gdshader`)
* **How it works:** Slides two independent 3D noise fields past each other in opposite directions. A sharp cel-shaded threshold step converts the intersecting lines into stylized cartoon water foam that looks clean from any distance.
* **Best use:** Stylized RPG water elements, magical liquid flasks, or water planets.

---

## 🧠 Behind the Math: Why These Look So Good
Older versions of these shaders used flat 2D screen-billboarding math, which caused the meshes to glitch or turn transparent when looked at directly. 

This updated pack fixes that completely by mapping everything via **3D Spatial Coordinates (`VERTEX`)** instead of flat 2D `UV` sheets. 

> **The Result:** The textures wrap seamlessly around the spheres without any ugly stretching, tearing, or pinching at the poles, remaining fully solid and visible from every possible camera angle.

---

## 🛠️ Installation & Project Setup

### Option A: Importing the Whole Project (Recommended)
If you want to clone this entire repo and see everything working right out of the box:
1. Download or clone this repository to your computer.
2. Open the **Godot Project Manager** and click **Import**.
3. Browse to this folder, select the `project.godot` file, and open it.
4. Open and run `Scenes/showcase_scene.tscn` (or press **F6**) to see all four spheres running live side-by-side with a real-time hardware FPS counter script!

### Option B: Dropping Individual Shaders Into Your Game
If you just want to copy a single shader into an existing project:
1. Open your game project folder and copy the desired `.gdshader` file from the `Shaders/` folder into your file system.
2. Inside Godot, add a `MeshInstance3D` to your scene and set its mesh to a **SphereMesh**.
3. Under the mesh's material property, create a **New ShaderMaterial**.
4. Edit the shader, paste the code inside, and adjust the speeds and colors directly using the uniform sliders in the inspector!

---

## ⚙️ Specifications
* **Engine Version:** Developed and tested inside **Godot 4.7**
* **Renderers Supported:** Forward+, Mobile, and Compatibility (WebGL friendly)
* **Dependencies:** Pure GDScript and GLSL Shading Language (None)
