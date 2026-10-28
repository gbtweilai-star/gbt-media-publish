# media_publish

**One capability bit from GBT V8, packaged standalone.** No. 330 of 341,
`video` domain (Video).

<p>
<img alt="python" src="https://img.shields.io/badge/python-3.9%2B-blue">
<img alt="license" src="https://img.shields.io/badge/license-MIT-green">
<img alt="deps" src="https://img.shields.io/badge/runtime%20dependencies-0-brightgreen">
</p>

> 三方向**发布到赚钱平台**的准备与授权门：`platforms <方向>` 读平台口径（**音乐复用能力位 `music_publishing` 的 13 平台，不另造**；短视频 7 / 电影 6 为内置候选表，**全部标「未核实」**）· `prepare` 备发布包（产物 sha256 + 许可摘录 + 元数据模板 + 目标平台 + 闸清单，落 `projects/_shared/publish/`，**不污染 18 格抽屉**）· `submit` **永远 blocked**（发布=不可逆外部动作，需主人 `deploy_publish` 一次性授权；本机零平台凭据；`media_pipeline.publish` 明写「不接受自带令牌绕门」）。**零出网、不发任何请求、绝不返回「已发布」** —— 自动化的终点站是主人的门。

That description is copied verbatim from the registry. `tests/test_spec.py` pins it,
so documentation drift fails the build instead of shipping quietly.

## What this package actually is

It is the **contract** for one capability: its name, its parameters, the values it
accepts, and whether it can change state that cannot be restored. It is not the
implementation — that lives in the runtime this bit was extracted from.

So `run()` goes through a narrow `Backend` protocol, and the default backend is a
stub that **says so**:

```
status="validated"   backend="stub"   data={"executed": false}
```

Never `status="ok"`. A stub that reports success is worse than no stub, because the
caller stops looking for the real thing.

## Install

```bash
git clone https://github.com/gbtweilai-star/gbt-media-publish.git
cd gbt-media-publish
python -m pip install -e ".[dev]"
```

## Use

```bash
python -m gbt_media_publish info                  # capability card
python -m gbt_media_publish spec --json           # machine-readable contract
python -m gbt_media_publish check --payload '{}'
python -m gbt_media_publish run   --payload '{}'
```

Real `info` output from this machine:

```text
media_publish  (video)  v1.0.0
----------------------------------------
三方向**发布到赚钱平台**的准备与授权门：`platforms <方向>` 读平台口径（**音乐复用能力位 `music_publishing` 的 13 平台，不另造**；短视频 7 / 电影 6 为内置候选表，**全部标「未核实」**）· `prepare` 备发布包（产物 sha256 + 许可摘录 + 元数据模板 + 目标平台 + 闸清单，落 `projects/_shared/publish/`，**不污染 18 格抽屉**）· `submit` **永远 blocked**（发布=不可逆外部动作，需主人 `deploy_publish` 一次性授权；本机零平台凭据；`media_pipeline.publish` 明写「不接受自带令牌绕门」）。**零出网、不发任何请求、绝不返回「已发布」** —— 自动化的终点站是主人的门。

gated      : True   <- needs explicit consent
external   : False
multi-op   : False
params     : (none)
```

Wire a real implementation:

```python
from gbt_media_publish import run

class MyBackend:
    name = "my-backend"
    def invoke(self, cap, payload):
        return {"cap": cap, "handled": sorted(payload)}

result = run({}, backend=MyBackend())
assert result.status == "ok"
```

## Parameters

| name | required | notes |
|---|---|---|
| — | no | the registry declares no required parameters |

Registry hint (`params_hint`): (empty)

Types are deliberately absent: the registry does not declare them, and an invented
type is worse than no type, because callers believe it.

## Boundaries

- Gated: this bit is marked `safe: false` in the registry — it can change state that no inverse action restores.
- No external service dependency declared.
- Single-action bit.
- No implementation ships here. Bring a backend; the protocol is one method.

## What this is not

Not a wrapper around a hosted API. Not a model. Not a promise that calling it does
anything on its own. It is the typed seam plus the validation, which is the part that
stays correct even when the implementation changes.

## Tests

```bash
python -m pytest
```

```text
20 passed, 3 skipped in 0.12s
```

## Provenance

| field | value |
|---|---|
| capability | `media_publish` |
| domain | `video` |
| handler | `media_publish` |
| safe | `False` (gated = `True`) |
| external | `False` |
| atlas page | [video/media_publish](https://github.com/gbtweilai-star/gbt-caps/blob/main/caps/video/media_publish.md) |
| full index | [https://github.com/gbtweilai-star/gbt-caps](https://github.com/gbtweilai-star/gbt-caps) |

The parent README says 348 capabilities; an AST pass over the registry enumerates
`341 + 0 unimplemented + 0 disabled = 341`. The extra 7 are historical duplicates.
Numbering here follows 341 and matches the `gbt-caps` index one-to-one.

## License

MIT.
