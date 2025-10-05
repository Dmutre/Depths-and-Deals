# Core Mechanics – Depths & Deals

## 🧭 Experience Overview
**Fishing Journey** is a cozy 2D game about a fisherman who catches, sells, and cooks fish to improve his tools, explore new waters, and unlock hidden markets.  
The core goal is to gain experience, upgrade equipment, discover new fishing spots, and complete quests for the local villagers.
# 🎣 Fishing Journey  
*A 2D pixel-art fishing adventure built with Godot Engine.*

---

## 🧭 Experience Overview
**Fishing Journey** is a cozy 2D game about a fisherman who catches, sells, and cooks fish to improve his tools, explore new waters, and unlock hidden markets.  
The core goal is to gain experience, upgrade equipment, discover new fishing spots, and complete quests for the local villagers.

---

## 🧑‍💻 Experience Information

| Field | Details |
|--------|----------|
| **Engine** | Godot 4 (2D project) |
| **Developers** | Team TBD |
| **Genre** | Fishing / Adventure / Simulation |
| **Target Audience** | Everyone (E) |
| **Platforms** | PC (Windows/Linux), potentially mobile |
| **Art Tools** | Aseprite / PixelLab |
| **Reference Games** | *Creatures of the Deep*, *Farm and Fish* |
| **Asset Guide** | [Pixel Art Tutorial](https://www.youtube.com/watch?v=zEfBPmPDUVc) |

---

## 🎮 Gameplay Overview

### Objectives
- Catch, collect, and sell fish.  
- Cook dishes to increase fish value.  
- Upgrade fishing gear, boat, and storage.  
- Complete quests and daily tasks to earn money and experience.  
- Unlock new fishing locations and recipes.  
- Fill out the fish catalog (collection system with rarities).  

### Story Context
> The player lives in a small fishing village. Local people request help — like Grandma Margaret, who needs fish for her family dinner. Completing quests helps the player grow their reputation and discover new locations and opportunities.

---

## 🔁 Gameplay Loop

| Step | Action |
|------|--------|
| 1 | Travel by boat to a fishing area. |
| 2 | Catch fish using interactive fishing mechanics. |
| 3 | Store fish in the inventory or warehouse (limited capacity). |
| 4 | Sell fish or cook them into dishes for higher value. |
| 5 | Earn money → buy upgrades, recipes, new tools. |
| 6 | Complete quests → gain XP, unlock new content. |
| 7 | Discover new fishing spots and rare species. |

---

## ⚙️ Core Mechanics

| Mechanic | Description |
|-----------|-------------|
| **Fishing System** | Interactive casting and reeling with a chance of rod breakage if the fish is too heavy. |
| **Boat Movement** | Navigate between lakes, rivers, and seas. |
| **Fish Catalog** | Unlockable collection log with rarity levels and personal record sizes. |
| **Inventory System** | Manage storage for items and fish; upgradable capacity. |
| **Quest System** | NPCs offer story and daily tasks with rewards. |
| **Cooking System** | Cook dishes to enhance fish value or fulfill orders. |
| **Recipe Unlocks** | Earned via quests or purchased; some require better tools. |
| **Market System** | Sell or buy items at different locations (town, village, port). |
| **Level Progression** | Gain XP from fishing and quests; unlock better tools and areas. |
| **Daily Tasks** | Rotating small quests for consistent engagement. |

---

## 🪙 Progression System

- **Early Game:** Simple rod, small inventory, local river fishing.  
- **Mid Game:** New tools, recipes, and locations; better fish and cooking profits.  
- **Late Game:** Unlock legendary fish, advanced cooking, upgraded home.  
- **Endgame:** Complete catalog, daily quests, record-breaking catches, optimized trade.

---

## 🧩 Pixel Art Scale & Design Guidelines

| Element | Recommended Size (px) | Notes |
|----------|-----------------------|-------|
| **Base Resolution** | 480×270 | Scales ×4 → 1920×1080 |
| **Tile Size** | 32×32 | Standard for terrain and water |
| **Player Sprite** | 32×48 | Standing character |
| **NPCs** | 32×48 | Match player proportions |
| **Fish Sprites** | 16×16 – 24×24 | Vary by species rarity |
| **Inventory Items** | 16×16 | Fits inventory grid |
| **Boat** | ~64×96 | Large enough for player |
| **Buildings** | 128–256 width | Houses, markets |
| **UI Icons** | 16×16 or 32×32 | Consistent pixel scaling |

**Rendering Settings (Godot):**
- Pixel Snap: `ON`  
- Viewport Stretch Mode: `2D`  
- Aspect: `Keep`  
- Use integer scaling (×2, ×3, ×4) for crisp pixels.  

---

## 🎨 Design Style

| Category | Description |
|-----------|-------------|
| **Art Style** | Hand-drawn pixel art with warm tones and soft lighting. |
| **Setting** | Small fishing villages, calm rivers, lakes, sea harbors. |
| **Mood** | Relaxing, rewarding, semi-realistic with cozy atmosphere. |
| **Characters** | Expressive but simple pixel-art NPCs. |

---

## 🧠 MVP (Minimum Viable Product)

**Goal:** Create a playable prototype with core systems.

**Must-have features:**
- Fishing mechanic (catch → success/fail).  
- Simple inventory and selling system.  
- One small map (lake) + 2 NPCs.  
- One quest (sell fish to Grandma).  
- Basic UI and player control.  

---

## 🐟 References
- **Games:** *Creatures of the Deep*, *Farm and Fish*  
- **Pixel Art Tutorial:** [https://www.youtube.com/watch?v=zEfBPmPDUVc](https://www.youtube.com/watch?v=zEfBPmPDUVc)

---

### 📌 Missing Sections You Can Add Later
To make this README a full **Game Design Document**, consider adding:
1. **Gameplay Flow Table** – step-by-step player actions per session.  
2. **Monetization Strategy** – if you add optional cosmetics or upgrades.  
3. **Risk Analysis** – list possible blockers (time, team size, scope).  
4. **Target Dates** – milestones (Prototype → Alpha → Beta → Release).  
5. **Concept Art & References** – attach images once assets are ready.  

---

