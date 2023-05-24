# Chef-test

```bash
cookbooks/
└── your_cookbook/
    ├── recipes/
    │   ├── default.rb
    │   ├── opensearch.rb
    │   ├── opensearch_dashboards.rb
    │   ├── nginx.rb
    │   └── golang_deploy.rb
    ├── templates/
    │   └── default/
    │       ├── config.yml.erb
    │       └── nginx.conf.erb
    ├── files/
    │   └── default/
    │       └── your_golang_app_binary
    └── metadata.rb
```

上述结构中的关键文件和文件夹说明如下：

- `your_cookbook/`：Cookbook的根目录，其名称根据您的Cookbook名称而定。
- `recipes/`：存放Cookbook的recipes的文件夹。
- `default.rb`：Cookbook的默认recipe，可以在此文件中引入其他recipes。
- `opensearch.rb`、opensearch_dashboards.rb、nginx.rb、golang_deploy.rb：各个组件的recipes文件。
- `templates/`：存放ERB模板的文件夹。
- `default/`：存放默认模板的子文件夹。
- `config.yml.erb、nginx.conf.erb`：示例模板文件，可以根据需求创建更多模板文件。
- `files/`：存放文件资源的文件夹。
- `default/`：存放默认文件资源的子文件夹。
- `your_golang_app_binary`：您的Golang程序的二进制文件。

## golang_deploy.rb

针对配置文件的处理部分：

- `file` 资源用于在本地文件系统上创建配置文件并将内容写入
- `remote_file` 资源用于将本地配置文件移动到远程服务器上指定的路径

- - -

- `/path/to/your/golang/app`：本地文件系统上Golang程序的路径。
- `/path/to/your/golang/source/main.go`：Golang程序源文件的路径。
- `/path/to/your/config.yml`：本地文件系统上配置文件的路径。
- `/etc/nginx/nginx.conf`：远程服务器上的Nginx配置文件路径。
- `/path/on/remote/server/golang_app`：远程服务器上Golang程序的目标路径。
- `/path/on/remote/server/config.yml`：远程服务器上配置文件的目标路径。
- `remote_user`：远程服务器上的目标用户。
- `remote_group`：远程服务器上的目标用户组。

## erb

创建对应的ERB模板是为了在Chef中动态生成配置文件或其他文本文件。ERB是Embedded Ruby的缩写，它允许在模板中嵌入Ruby代码，从而能够根据变量和逻辑来生成最终的文本内容
使用ERB模板的好处是可以使配置文件更具灵活性和可维护性，而不需要在Chef代码中硬编码大量的静态文本。通过将配置文件的内容和变量分离开来，可以更方便地修改和管理配置

以下是使用ERB模板的主要优势：

- `动态生成内容`：ERB模板允许在模板中使用Ruby代码，可以根据Chef recipe中的变量、条件和循环等逻辑来动态生成最终的配置文件内容。
- `提高可维护性`：通过将配置文件内容与Chef代码分离，可以更容易地理解和修改模板，而无需在Chef代码中进行复杂的字符串操作。
- `易于扩展和修改`：如果需要修改配置文件的某些部分，只需要修改相应的模板文件，而无需修改Chef代码中的字符串内容。
- `更好的重用性`：可以使用相同的模板来生成不同的配置文件，只需通过传递不同的变量值即可。

总之，通过使用ERB模板，可以将配置文件的生成和维护与Chef代码分离开来，使配置过程更加灵活、可维护和可重用
当然，对于简单的配置文件，可以直接在Chef代码中使用字符串进行硬编码。但随着配置的复杂性增加，使用ERB模板可以提供更好的可读性和可维护性

在生成模板时，我们使用 <%= %> 语法来嵌入变量，并将其传递给模板。在这个例子中，node['opensearch']['option1'] 和 node['opensearch']['option2'] 是 Chef 节点的属性，可以在 Chef 的配置中定义或通过其他方式设置

通过在 template 资源中使用 variables 参数，我们可以将变量传递给模板，并在模板中使用这些变量来生成最终的配置文件内容

## template

在 Chef 中，notifies 是一个通知机制，用于在特定条件下触发其他资源的操作。它是 Chef 中的一种资源属性，用于声明资源之间的依赖关系和触发顺序

具体地说，notifies 属性允许在当前资源执行成功后通知其他资源执行特定的操作。通常情况下，notifies 属性会被设置为触发一个资源的动作，比如 :restart 表示重新启动资源

在上述的例子中，notifies 属性被用于在模板文件 /etc/nginx/nginx.conf 更新后，通知 Nginx 服务进行重启

具体来说，这段代码：指定了在模板文件更新后，通知 nginx 服务进行重启。:restart 表示重启操作，'service[nginx]' 表示要通知的资源是 nginx 服务资源。
而 :delayed 表示这个通知是一个延迟通知，即在整个 Chef Run 完成后才会执行。这意味着当模板文件更新时，Nginx 服务不会立即重启，而是在整个 Chef Run 结束后，根据触发通知的条件执行重启操作
