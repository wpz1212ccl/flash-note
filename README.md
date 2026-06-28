# 闪念 FlashNote

> **灵感来了？打开即写，写完即走。**

一款完全离线、完全本地的移动端灵感笔记 + 定时提醒 App。

[![Flutter](https://img.shields.io/badge/Flutter-3.24+-02569B?logo=flutter)](https://flutter.dev)
[![Dart](https://img.shields.io/badge/Dart-3.5+-0175C2?logo=dart)](https://dart.dev)
[![License](https://img.shields.io/badge/License-MIT-green.svg)](LICENSE)

---

## 产品展示

<table>
  <tr>
    <td align="center"><img src="docs/screenshots/2783DC4ED63B6B4AD453B61FA63CBB62.jpg" width="240"/></td>
    <td align="center"><img src="docs/screenshots/86E33E468BA5344DB09487AE156A6B3F.jpg" width="240"/></td>
    <td align="center"><img src="docs/screenshots/9F126F68972745B582D6DD429CA2745D.jpg" width="240"/></td>
  </tr>
  <tr>
    <td align="center">灵感列表</td>
    <td align="center">深色模式</td>
    <td align="center">待办提醒</td>
  </tr>
</table>

---

## 核心特性

- **零网络依赖** — 不声明 INTERNET 权限，数据完全本地存储，隐私第一
- **极速记录** — 打开即写，支持全局速记浮层，灵感不等待
- **双视图模式** — 时间线视图 + 网格视图，自由切换
- **智能提醒** — 本地通知定时提醒，不错过任何灵感
- **全文搜索** — 基于 SQLite FTS5 的快速检索
- **深色模式** — 完整的浅色/深色主题支持
- **标签分类** — 6 种预设标签色，灵感/随笔/工作/梦境/情绪/生活
- **数据导出** — 支持 JSON / Markdown / 纯文本三种格式导出

---

## 技术架构

```
架构模式:    单一代码库 + 分层架构
状态管理:    Riverpod 2.x (响应式)
数据库:      Drift 2.x (SQLite ORM + FTS5)
路由:        GoRouter 14.x
本地通知:    flutter_local_notifications 17.x
设计系统:    自定义 Design Tokens (颜色/字号/间距/动画)
```

### 项目结构

```
lib/
├── core/           # 设计系统与工具
│   ├── constants/  # 颜色、字号、间距、动画时长常量
│   ├── theme/      # ThemeData 构建 + Riverpod 主题状态
│   └── utils/      # 日期格式化、触觉反馈
├── data/           # 数据层
│   ├── database/   # Drift 表定义、DAO、数据库主体
│   └── repositories/  # 业务逻辑封装
├── providers/      # Riverpod Provider
├── features/       # 页面模块
│   ├── home/       # 主页 (时间线 + 网格)
│   ├── capture/    # 速记页 + 全局浮层
│   ├── detail/     # 详情页
│   ├── todo/       # 待办提醒
│   ├── settings/   # 设置页
│   └── search/     # 全局搜索
├── shared/         # 公共组件
└── services/       # 通知、存储、导出服务
```

---

## 开发过程

本项目采用 **Vibe Coding** 开发模式 —— 与 AI Agent (Claude Code) 协同完成从产品设计到代码实现的全流程。

### 开发流程

1. **需求定义** — 通过自然语言描述产品定位和功能约束
2. **架构设计** — AI 生成分层架构方案和目录结构
3. **渐进实现** — 按模块逐步生成代码，每步验证
4. **动效打磨** — 弹簧动画、交错列表、Hero 过渡等细节
5. **性能优化** — 懒加载、RepaintBoundary、Stream 响应式

### 关键设计决策

| 决策 | 方案 | 理由 |
|------|------|------|
| 状态管理 | Riverpod | 编译时安全，Provider 自动刷新 |
| 数据库 | Drift (SQLite) | 类型安全 ORM，支持 FTS5 全文检索 |
| 路由 | GoRouter | 声明式路由，支持 ShellRoute 保持状态 |
| 离线优先 | 零网络依赖 | 隐私保护，随时可用 |

---

## 快速开始

```bash
# 克隆项目
git clone https://github.com/wpz1212ccl/flash-note.git
cd flash-note

# 安装依赖
flutter pub get

# 代码生成
dart run build_runner build --delete-conflicting-outputs

# 运行
flutter run
```

### 环境要求

- Flutter >= 3.24
- Dart >= 3.5
- Android API 24+ / iOS 13.0+

---

## 性能指标

| 指标 | 目标 | 实现 |
|------|------|------|
| 冷启动 | < 500ms | LazyDatabase + 按需加载 |
| 列表滚动 | 120fps | SliverList.builder + RepaintBoundary |
| 安装包 | < 15MB | 不内嵌字体，运行时加载 |

---

## 关于开发者

**PgStar** — AI Product & Mobile App Developer



---

## License

MIT License
