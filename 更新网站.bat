@echo off
chcp 65001 > nul
echo ========================================
echo    学术公众号导航网站 - 自动更新脚本
echo ========================================
echo.

REM 检查是否安装了 Git
where git >nul 2>nul
if %ERRORLEVEL% NEQ 0 (
    echo [错误] 未检测到 Git，请先安装 Git
    echo.
    echo 安装方法：
    echo 1. 访问 https://git-scm.com/download/win
    echo 2. 下载并安装 Git
    echo 3. 重新运行此脚本
    echo.
    pause
    exit /b 1
)

REM 检查是否已配置 Git
git config user.name >nul 2>nul
if %ERRORLEVEL% NEQ 0 (
    echo [提示] 首次使用，需要配置 Git
    echo.
    set /p USERNAME=请输入你的 GitHub 用户名（例如：academic-nav-2026）：
    set /p EMAIL=请输入你的 GitHub 邮箱：
    git config --global user.name "%USERNAME%"
    git config --global user.email "%EMAIL%"
    echo.
    echo [成功] Git 配置完成！
    echo.
)

echo [步骤 1/5] 正在检查网站文件...
if not exist "index.html" (
    echo [错误] 未找到 index.html 文件
    echo 请确保 index.html 在当前文件夹中
    echo.
    pause
    exit /b 1
)
echo [完成] 找到 index.html
echo.

echo [步骤 2/5] 正在更新网站...
echo 提交信息：更新网站内容 - %date% %time%
git add index.html
git commit -m "更新网站内容 - %date% %time%"

echo [步骤 3/5] 正在上传到 GitHub...
git push origin main

if %ERRORLEVEL% EQU 0 (
    echo.
    echo ========================================
    echo [成功] 网站更新完成！
    echo ========================================
    echo.
    echo 访问你的网站：
    echo https://academic-nav-2026.github.io/academic-nav/
    echo.
    echo 等待 1-3 分钟，网站会自动更新
) else (
    echo.
    echo ========================================
    echo [错误] 上传失败！
    echo ========================================
    echo.
    echo 可能的原因：
    echo 1. 网络连接问题
    echo 2. GitHub 凭证过期
    echo 3. 权限问题
    echo.
    echo 请检查错误信息并重试
)

echo.
pause
