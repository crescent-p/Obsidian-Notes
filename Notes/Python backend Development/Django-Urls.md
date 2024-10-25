In Django, **URL routing** is the process of mapping URLs to views, allowing specific URLs to trigger specific functions (views) in your application. This is a core feature that enables Django to handle HTTP requests and return responses.

### How URL Routing Works in Django:
1. **URLconf (URL configuration)**
   - URL routing is managed through URL configuration (URLconf). It’s typically defined in a `urls.py` file, where URL patterns (or paths) are mapped to views.
   - Each URL pattern consists of a regular expression or a path expression and is associated with a specific view.

2. **Basic URL Pattern Syntax**
   A basic URL pattern is created using the `path()` function inside `urls.py`. For example:

   ```python
   from django.urls import path
   from . import views

   urlpatterns = [
       path('home/', views.home_view),
       path('about/', views.about_view),
   ]
   ```

   - **`'home/'`**: This is the URL pattern. When someone visits `yourwebsite.com/home/`, it will trigger `home_view`.
   - **`views.home_view`**: The view function that will be executed when this URL is accessed.

3. **Including URL Patterns from Other Apps**
   For larger projects, it’s common to have multiple apps, each with its own `urls.py` file. In this case, you can include URLs from other apps in the main project's `urls.py`.

   Example in `myProject/urls.py`:

   ```python
   from django.urls import include, path

   urlpatterns = [
       path('blog/', include('blog.urls')),
   ]
   ```

   Here, any URL starting with `/blog/` will be handled by the URL patterns defined in the `blog` app's `urls.py`.

4. **Dynamic URLs (URL Parameters)**
   URL routing in Django supports dynamic URLs that capture variables and pass them to views. This is done using `<variable>` in the `path()` function.

   ```python
   from django.urls import path
   from . import views

   urlpatterns = [
       path('article/<int:id>/', views.article_detail),
   ]
   ```

   In this case, visiting a URL like `yourwebsite.com/article/42/` will pass `42` as an `id` parameter to the `article_detail` view function.

5. **Path Converters**
   Django provides path converters to capture specific types of data from URLs:
   - **`<int:id>`**: Captures an integer.
   - **`<str:name>`**: Captures a string.
   - **`<slug:slug>`**: Captures a slug (a short label, often used in URLs).
   - **`<uuid:uuid>`**: Captures a universally unique identifier (UUID).
   
   Example:

   ```python
   path('user/<str:username>/', views.user_profile),
   ```

6. **Default `urls.py` Structure**
   When you create a new Django project using `django-admin startproject`, a default `urls.py` file is created. It often looks like this:

   ```python
   from django.contrib import admin
   from django.urls import path

   urlpatterns = [
       path('admin/', admin.site.urls),
   ]
   ```

   Here, the default admin interface is mapped to the `/admin/` URL.

### Example:
Suppose you have the following URL pattern:

```python
urlpatterns = [
    path('', views.homepage),
    path('contact/', views.contact_page),
    path('product/<int:product_id>/', views.product_detail),
]
```

- The first URL (`''`) is for the homepage.
- The second URL (`'contact/'`) is for a contact page.
- The third URL (`'product/<int:product_id>/'`) captures an integer `product_id` from the URL and passes it to the `product_detail` view.

### Summary of URL Routing Process:
1. Django starts at the first pattern in `urlpatterns` and moves down until it finds a matching pattern.
2. If a match is found, Django calls the corresponding view function with the captured parameters.
3. If no match is found, Django raises a **404 Not Found** error.

