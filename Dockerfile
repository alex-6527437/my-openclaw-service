# 使用一個 Debian Base Image 作為基礎
FROM debian:bookworm-slim

# 設定工作目錄
WORKDIR /app

# 安裝 OpenClaw 服務所需的系統工具
# 這會安裝 sudo, curl, python3-pip, smbclient 和 ping
RUN apt-get update && apt-get install -y --no-install-recommends \
    sudo \
    curl \
    python3-pip \
    smbclient \
    iputils-ping \
    # 安裝 Tailscale (透過官方腳本)
    && curl -fsSL https://tailscale.com/install.sh | sh \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# 可選：設定 Tailscale 相關的環境變數，有助於偵錯
ENV TS_DEBUG_FIREWALL=1

# 這裡假設你的 OpenClaw 服務的實際程式碼會由 Zeabur 自動注入到 /app
# 如果不是，你需要額外指令去複製你的 OpenClaw 程式碼到 /app

# 定義 OpenClaw Gateway 的啟動指令
# 這必須符合你的 OpenClaw 服務的實際啟動方式
CMD ["node", "/app/dist/gateway/index.js"]