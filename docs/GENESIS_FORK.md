# Genesis Fork Architecture

## Overview

Genesis Video Desktop extends LTX Desktop to support any video generation backend.

## Remote Backend Mode

The PC acts as the UI only. Generation runs on the server at `http://100.90.93.123:8000`.

Set via environment variable:
```
LTX_REMOTE_BACKEND_URL=http://100.90.93.123:8000
```

Or via the Settings panel in the UI (Phase 5 work).

## Model Registry

See `models.genesis.json` for the universal model registry format.

## Supported Engines

| Engine | Status |
|--------|--------|
| LTX (server) | Active |
| Wan image-to-video | Planned |
| Wan text-to-video | Planned |
| HunyuanVideo | Planned |
| AnimateDiff | Planned |
| ComfyUI workflows | Planned |

## Server API

The server at `http://100.90.93.123:8000` implements the LTX Desktop API:

- `GET /health`
- `GET /api/settings`
- `POST /api/settings`
- `GET /api/generate/models-specs`
- `GET /api/models/ltx-recommendation`
- `GET /api/models/img-gen-recommendation`
- `POST /api/generate`
- `POST /api/generate/cancel`
- `GET /api/generation/progress`

Plus Genesis extensions:
- `GET /api/genesis/models`
- `POST /api/genesis/generate`
- `GET /api/genesis/gpus`
- `GET /api/genesis/workflows`
- `GET /api/genesis/adapters`
