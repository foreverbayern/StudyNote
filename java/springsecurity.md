本质是一个过滤器链

重点的过滤器：

1. FilterSecurityInterceptor
2. ExceptionTranslationFilter:异常过滤器，处理在认证授权过程中抛出的异常。  
3. UsernamePasswordAuthenticationFilter: 对/login的post请求做拦截，校验表单中用户名,密码

过滤器的加载：
(springboot已经自动配置好了)
1. 使用springsecurity配置过滤器
* delegatingFilterProxy

两个重要的接口：
UserDetailsService:自定义开发，去查数据库的过程。  创建一个类继承UsernamePasswordAuthenticationFilter，重写三个方法。

PasswordEncoder：对密码的加密接口，用于返回user对象里密码加密



基于角色或权限进行访问控制：
hasAuthority：如果当前的主体具有指定的权限，则返回true，否则返回false