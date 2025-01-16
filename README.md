# mvvm_riverpod

A example flutter app movies using [MVVM](https://learn.microsoft.com/pt-br/windows/uwp/data-binding/data-binding-and-mvvm) with [Riverpod](https://pub.dev/packages/riverpod) state management.

## Getting Started

`git clone git@github.com:kauemurakami/mvvm_riverpod.git`
<br/>

**Create account** in [The movie db](https://www.themoviedb.org/).
After, click in your picture/initial letter name circle in top right, find `settings`, in `settings` find for `API` and you can see your API's `api key` and `token`.
<br/>

#### Create file .env
In your project root folder, in the case is `mvvm_riverpod`, right click, select the option `create folder` named it with `assets`, inside `create file` with name `.env`. Now in your `pubspec.yaml` go at section `assets`.
```yaml
assets:
    - assets/.env
```
```.env
MOVIES_API_KEY = "YOUR_API_KEY"
MOVIES_BEARERTOKEN = "YOUR_API_TOKEN"
```

#### Run project

`flutter packages get`
<br/>

`flutter run`
