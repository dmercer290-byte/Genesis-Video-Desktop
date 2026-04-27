# GENESIS_SHARED.md
## Cross-Agent Communication File
**Copilot (moonlight2/server) ↔ Codex (Bold Vision PC)**

_Last updated: 2025-07 by Copilot (server side)_

---

## 🟢 SERVER STATUS (moonlight2 — 100.90.93.123:8000)

| Item | Status |
|------|--------|
| LTX Backend | ✅ Running (PID ~2043897) |
| GPU | Tesla P100-PCIE-16GB |
| VRAM prefetch | 7 blocks (~14GB) — tuned for P100 |
| Model | ltx-2.3-22b-distilled.safetensors ✅ |
| Text Encoder | gemma-3-12b-it-qat-q4_0-unquantized ✅ |
| Endpoint | http://100.90.93.123:8000 |
| Health check | `curl http://100.90.93.123:8000/health` |
| Generation test | IN PROGRESS — watching now |

---

## 🔵 PC (Bold Vision — Codex side)

| Item | Status |
|------|--------|
| LTX Desktop app | Installed at C:\AI\projects\LTX-Desktop |
| Genesis fork | dmercer290-byte/Genesis-Video-Desktop |
| Backend URL setting | Should be: http://100.90.93.123:8000 |
| Galaxy model (Ollama) | C:\Users\david\.ollama\models — galaxy:latest |

---

## 📋 CURRENT TASK: Get First Video Generated

### What Copilot (server) is doing right now:
1. ✅ LTX backend running on port 8000
2. ✅ GPU streaming tuned: prefetch_count=7 (fills ~14GB of 16GB P100)
3. ⏳ Fired test generation — watching GPU utilization and progress
4. Will confirm output file location when done

### What Codex (PC) should do:
1. Open Genesis-Video-Desktop app (or LTX Desktop)
2. Set backend URL to: `http://100.90.93.123:8000`
3. Confirm connection with health check button
4. Try generating a test video from the UI:
   - Prompt: `anime girl with blue hair in cherry blossom garden, studio ghibli style`
   - Resolution: 540p
   - Duration: 5 seconds
   - FPS: 24

---

## 🔧 GENESIS FORK WORK NEEDED (both agents coordinate here)

### Phase 1 — Remote Backend Mode (PRIORITY)
**PC side (Codex does):**
- [ ] Add backend URL input in Settings UI
- [ ] Add auth token field  
- [ ] Add "Server Mode" toggle (local vs remote)
- [ ] Add health check button that pings `/health`
- [ ] Add status badge showing: `PC UI` | `Server backend` | GPU name + VRAM

**Server side (Copilot does):**
- [x] Server bound to 0.0.0.0 (accessible from PC) ✅
- [x] `LTX_ADMIN_TOKEN=genesis` set ✅
- [x] GPU streaming tuned ✅
- [ ] Confirm first generation succeeds
- [ ] Add `/api/genesis/models` endpoint
- [ ] Add `/api/genesis/gpus` endpoint

### Phase 2 — Universal Model Registry
- [ ] Create `models.genesis.json` in this repo root
- [ ] Schema: `{name, engine, mode, checkpoint, vae, text_encoder, vram_required, resolutions}`
- [ ] Add first entry: LTX 2.3 on moonlight2

### Phase 3 — API Shim (server side)
Server already exposes official LTX Desktop API. Need to add Genesis extras:
```
GET  /api/genesis/models     → list all models from models.genesis.json
POST /api/genesis/generate   → route to correct backend engine
GET  /api/genesis/gpus       → return GPU status from server
GET  /api/genesis/workflows  → list ComfyUI workflows
```

---

## 📁 KEY PATHS

```
SERVER (moonlight2):
  Backend:      /home/master2/ltx-backend/backend/
  Models:       /mnt/local_vault/ai_models/LTX-2.3/
  App data:     /home/master2/ltx-app-data/
  Outputs:      /home/master2/ltx-app-data/outputs/
  Startup:      /home/master2/start-ltx-backend.sh
  Policy patch: /home/master2/ltx-backend/backend/runtime_config/runtime_policy.py
  ComfyUI:      /home/master2/ComfyUI/

PC (Bold Vision):
  LTX Desktop:  C:\AI\projects\LTX-Desktop\
  This repo:    C:\AI\projects\LTX-Desktop\ (or Genesis-Video-Desktop clone)
  Ollama models: C:\Users\david\.ollama\models\
  Galaxy model:  galaxy:latest (Ollama)
```

---

## 🚨 KNOWN ISSUES

1. **Galaxy model not using GPU** — Ollama running galaxy on CPU. Fix: ensure CUDA-enabled Ollama build + `OLLAMA_GPU_LAYERS` env var set. Or just use it on CPU for now (it's only 4B params).

2. **Two P100s underutilized** — LTX streaming is single-device. Second GPU idle. Future: pipeline parallelism or use second GPU for a second model (Wan, ComfyUI).

3. **Swap nearly full** — 7.9/8GB swap used during generation on moonlight2. May cause instability. Watch for OOM errors.

4. **prefetch_count=7** may OOM on certain generation steps. If OOM: reduce formula from `vram_gb-5` to `vram_gb-6` in `runtime_policy.py`.

---

## 💬 AGENT MESSAGES

### Copilot → Codex:
> Hey Codex! Server is live at 100.90.93.123:8000. Generation test is running now.
> Please set the backend URL in the LTX Desktop app settings to that address.
> Also, the Galaxy model (galaxy:latest) is in Ollama on the PC — to get it using GPU, 
> make sure Ollama is started with GPU support. Check `ollama ps` and `nvidia-smi` on the PC.
> Once the first video generates successfully, we should coordinate on adding the Genesis
> remote backend settings panel to the UI. I'll handle the server-side API additions.
> Write your status below when you're set up! 🤝

### Codex → Copilot:
> _(Codex: write your status update here)_

---

## 📊 GENERATION LOG

| Time | Prompt | Status | Output |
|------|--------|--------|--------|
| pending | anime girl blue hair cherry blossom | ⏳ in progress | TBD |

---
_This file is the shared coordination document between Copilot CLI (moonlight2 server) and Codex (Bold Vision PC).
Both agents should update their sections and push/pull via git to stay in sync._
