<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>登录 - 企业轻量资产管理系统</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        body {
            background: linear-gradient(135deg, #78350f 0%, #92400e 50%, #b45309 100%);
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
        }
        .login-container {
            background: white;
            border-radius: 20px;
            box-shadow: 0 20px 60px rgba(0,0,0,0.3);
            width: 100%;
            max-width: 420px;
            padding: 48px;
        }
        .login-header {
            text-align: center;
            margin-bottom: 32px;
        }
        .login-header .logo {
            width: 64px;
            height: 64px;
            background: #78350f;
            border-radius: 16px;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 16px;
        }
        .login-header h1 {
            font-size: 24px;
            font-weight: 700;
            color: #111827;
        }
        .login-header p {
            color: #6b7280;
            font-size: 14px;
            margin-top: 4px;
        }
        .login-form .form-group {
            margin-bottom: 20px;
        }
        .login-form .input-icon {
            position: relative;
        }
        .login-form .input-icon i {
            position: absolute;
            left: 14px;
            top: 50%;
            transform: translateY(-50%);
            color: #9ca3af;
        }
        .login-form .input-icon input {
            padding-left: 42px;
            height: 48px;
        }
        .login-btn {
            width: 100%;
            height: 48px;
            background: #78350f;
            color: white;
            border: none;
            border-radius: 8px;
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.2s;
        }
        .login-btn:hover {
            background: #92400e;
        }
        .login-footer {
            text-align: center;
            margin-top: 24px;
            font-size: 13px;
            color: #9ca3af;
        }
        .error-msg {
            background: #fee2e2;
            color: #991b1b;
            padding: 10px 16px;
            border-radius: 8px;
            font-size: 14px;
            margin-bottom: 16px;
            display: none;
        }
        .error-msg.show { display: block; }
    </style>
</head>
<body>
    <div class="login-container">
        <div class="login-header">
            <div class="logo">
                <i class="fas fa-boxes text-white text-2xl"></i>
            </div>
            <h1>资产管理系统</h1>
            <p>EAM Lite v1.0 - 企业轻量资产管理</p>
        </div>

        <% if (request.getAttribute("error") != null) { %>
        <div class="error-msg show">
            <i class="fas fa-exclamation-circle mr-2"></i>${error}
        </div>
        <% } %>

        <form class="login-form" action="${pageContext.request.contextPath}/login" method="post">
            <div class="form-group">
                <div class="input-icon">
                    <i class="fas fa-user"></i>
                    <input type="text" name="username" class="form-input" placeholder="请输入登录账号" required 
                           value="<%= request.getAttribute("username") != null ? request.getAttribute("username") : "" %>">
                </div>
            </div>
            <div class="form-group">
                <div class="input-icon">
                    <i class="fas fa-lock"></i>
                    <input type="password" name="password" class="form-input" placeholder="请输入密码" required>
                </div>
            </div>
            <button type="submit" class="login-btn">
                <i class="fas fa-sign-in-alt mr-2"></i>登录系统
            </button>
        </form>

        <div class="login-footer">
            <p>默认账号: admin / 123456 | asset / 123456</p>
            <p class="mt-2">&copy; 2024 企业轻量资产管理系统</p>
        </div>
    </div>
</body>
</html>