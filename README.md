# 🎮 Company Adventure - 2D Platformer Game Design (Updated)

## 🎯 Core Gameplay
- Single-player 2D platformer
- Focus on running and jumping (no enemies)
- Interactive points in levels:
  - **Computer** → Play video
  - **Picture frame** → Show image
  - **Signboard** → Show text/hints
- Collectible **coins**: gained in each department stage or found on the path, used for scoring
- **Lunch break** acts as a checkpoint: **save + heal**

---

## 📍 Stage Flow

### Stage 0: MRT → Honghui Tower
- **Scene**: Exit MRT station, walk on the street
- **Mechanic**: Cutscene option (MRT arrival animation)
- Enter **elevator** to go to Floor 14

---

### Stage 1: Honghui Tower F14 (Office Mini-stage)
- **Entrance**: Door to office
- **Inside**:
  1. Trigger **computer → video** (brief intro / department overview)
  2. Three-choice mini challenge (E-shaped / puzzle / small parkour)
- **Exit**: Door leading back to main floor / corridor
- **Implementation Suggestion**:
  - Use one small **scene for office**
  - Player enters door → open office scene → VideoPlayer + three branch choices → after completion, teleport player back to main map

#### Stage 1-1: RD Department (Jie)
- Optional extension if needed
- Parkour stage with RD-related desk items

#### Stage 1-2: SQA Department (Ryan)
- Optional extension
- SQA mini challenge stage

#### Stage 1-3: Lunch Break
- Location: Food court (13F / 7F)
- Function: **Checkpoint (save + heal)**
- Visual: Pantry / canteen
- Exit → back to city street

---

### Stage 2: Yue-Tower F22
#### Stage 2-1: Allen Department
- Trigger **computer → Allan’s video**
- Allan’s challenge stage
- Exit → elevator back to street

---

### Stage 3: Bade Factory (Big Vertical Stage)
- Elevator up to Floor 6, descend floor by floor

- **F6**: Rooftop garden + basketball court
- **F5**: Office → slide down to F4
- **F4**: Lecture hall (stairs leading to F3)
- **F3**: Café
- **F2**: Library
- **F1**: Lobby (exit)

---

### Stage 4: Ending
- Player jumps onto a **flagpole** (Mario-style)
- Show results screen:
  - Collected coins
  - Final score
  - Completed videos / images

---

## 🖼️ Art & Assets
- **Outdoor background**: city, skyscrapers, streets, MRT exit
- **Indoor background**: office, computers, meeting rooms, cafeteria, factory floors
- **Interactive objects**:
  - Computer (video playback)
  - Picture frame (full-screen image)
  - Signboard (text hint)
  - Door (trigger small office mini-scene)
- **UI**: health bar, coin counter, checkpoint icon

---

## 🔊 Audio
- Background music: cheerful 8-bit / lo-fi office tracks
- Jump: small jump SFX
- Coin: "ding"
- Save: floppy disk sound
- Video: computer boot sound

---

## ⚙️ Technical Notes (Godot)

### Office Mini-Stage
- One small scene triggered by **door Area2D**
- Inside scene:
  1. VideoPlayer node for department intro video
  2. Three-choice challenge (E-shaped / mini puzzle)
  3. After completion → teleport player back to main map

### Scene Transition (Elevator / Door / MRT)
- Use `Area2D + CollisionShape2D` to detect player overlap
- Can either `change_scene` or directly `player.position = Vector2(...)` if using a single large map

### Media Interaction
- **Images (frames)** → `CanvasLayer + TextureRect` popup
- **Text (signs)** → `CanvasLayer + Label` popup
- **Videos (computers)** → `VideoPlayer` node (requires `.ogv` format)

### Checkpoints
- Lunch break stage doubles as a save point
- Implemented with custom checkpoint system (store player position, coins, health)

### Results Screen
- Use `CanvasLayer` UI for final scoring
- Display coins, score, and media collected
