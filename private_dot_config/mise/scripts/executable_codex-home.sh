# ~/.config/mise/codex-home.sh
# Sourced by mise.

set_codex_home() {
  local codex_root=""
  local global_config="${HOME}/.codex/config.toml"

  # Prefer git root when inside a repo.
  if command -v git >/dev/null 2>&1; then
    codex_root="$(git -C "$CURRENT_WORKSPACE" rev-parse --show-toplevel 2>/dev/null || true)"
  fi

  if [ -n "$codex_root" ] && [ -d "$codex_root" ]; then
    export CODEX_HOME="${codex_root}/.codex-state"
    mkdir -p "$CODEX_HOME"

    # Seed config.toml only once.
    if [ ! -e "${CODEX_HOME}/config.toml" ] && [ -f "$global_config" ]; then
      cp "$global_config" "${CODEX_HOME}/config.toml"
      chmod 600 "${CODEX_HOME}/config.toml" 2>/dev/null || true
    fi
  else
    unset CODEX_HOME
  fi
}

set_codex_home
unset -f set_codex_home
