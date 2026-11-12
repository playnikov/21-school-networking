## Contents
[Настройка gitlab-runner](#part-1-настройка-gitlab-runner)  
[Сборка](#part-2-сборка)  
[Тест кодстайла](#part-3-тест-кодстайла)   
[Интеграционные тесты](#part-4-интеграционные-тесты)  
[Этап деплоя](#part-5-этап-деплоя)  

### Part 1. Настройка **gitlab-runner**

**== Задание ==**

##### Подними виртуальную машину *Ubuntu Server 22.04 LTS*.

![screen1](images/screen1.png)

##### Скачай и установи на виртуальную машину **gitlab-runner**.
`дальше через ssh подключимся на сервер для удобства установки`

![screen2](images/screen2.png)

```sh
sudo apt-get install gitlab-runner
```

```sh
systemctl status gitlab-runner
```

![screen3](images/screen3.png)

##### Запусти **gitlab-runner** и зарегистрируй его для использования в текущем проекте (*DO6_CICD*).
- Для регистрации понадобятся URL и токен, которые можно получить на страничке задания на платформе.

![screen4](images/screen4.png)

```sh
sudo gitlab-runner register
```

![screen5](images/screen5.png)

### Part 2. Сборка

**== Задание ==**

#### Напиши этап для **CI** по сборке приложений из проекта *C2_SimpleBashUtils*.


##### В файле _gitlab-ci.yml_ добавь этап запуска сборки через мейк файл из проекта _C2_.


##### Файлы, полученные после сборки (артефакты), сохрани в произвольную директорию со сроком хранения 30 дней.

![screen6](images/screen6.png)

**Если устанавливали через sudo apt-get install gitlab-runner и на гитлабе нет отображения:**
```sh
sudo chmod +x /usr/local/bin/gitlab-runner 
sudo gitlab-runner install --user=gitlab-runner --working-directory=/home/gitlab-runner
```

**В итоге при первом запуске получаем ошибку:**

![screen7](images/screen7.png)

> Среда не готова к запуску

> Комментируем строчки в файле **/home/gitlab-runner/.bash_logout

![screen8](images/screen8.png)

**Теперь сборка работает корректно**

![screen9](images/screen9.png)

### Part 3. Тест кодстайла

**== Задание ==**

#### Напиши этап для **CI**, который запускает скрипт кодстайла (*clang-format*).

##### Если кодстайл не прошел, то «зафейли» пайплайн.

##### В пайплайне отобрази вывод утилиты *clang-format*.


![screen10](images/screen10.png)

> **Испортим какой-нибудь файл**
![screen11](images/screen11.png)

> **Но с предупреждениями тест будет проходить, поэтому добавим флаг <br>-Werror**

![screen12](images/screen12.png)

![screen13](images/screen13.png)

![screen14](images/screen14.png)

> **Исправляем файл cat.c и получаем зеленый проект 😁**

![screen15](images/screen15.png)

### Part 4. Интеграционные тесты

**== Задание ==**

#### Напиши этап для **CI**, который запускает твои интеграционные тесты из того же проекта.

##### Запусти этот этап автоматически только при условии, если сборка и тест кодстайла прошли успешно.

##### Если тесты не прошли, то «зафейли» пайплайн.

##### В пайплайне отобрази вывод, что интеграционные тесты успешно прошли / провалились.


> **Этап тестирования:**

![screen16](images/screen16.png)

> **Скрипт для тестов и проверки на наличие фейлов:**

![screen17](images/screen17.png)

> **Этап запускается, тесты проходят**

![screen18](images/screen18.png)

> **Изменим cat.c, чтобы убедиться, что пайплайн фейлится**

![screen19](images/screen19.png)

> **Тесты не прошли:**

![screen20](images/screen20.png)

### Part 5. Этап деплоя

##### Подними вторую виртуальную машину *Ubuntu Server 22.04 LTS*.

> Первая машина:
![screen21](images/screen21.png)

> Вторая машина:
![screen22](images/screen22.png)

![screen23](images/screen23.png)

![screen24](images/screen24.png)

#### Напиши этап для **CD**, который «разворачивает» проект на другой виртуальной машине.

##### Запусти этот этап вручную при условии, что все предыдущие этапы прошли успешно.

##### Напиши bash-скрипт, который при помощи **ssh** и **scp** копирует файлы, полученные после сборки (артефакты), в директорию */usr/local/bin* второй виртуальной машины.

##### В файле _gitlab-ci.yml_ добавь этап запуска написанного скрипта.

##### В случае ошибки «зафейли» пайплайн.

![screen25](images/screen25.png)

![screen26](images/screen26.png)

> Перед началом проверки работоспособности необходимо проделать некоторые манипуляции
> 
> - **генерация ключей `ssh-keygen`**
> - **добавить ключ второй машины добавить в гитлаб `cat .ssh/id_rsa.pub`**
> - **настроить ssh-агента**
> - **Далее необходимо сохранить отпечаток удаленного сервера**

![screen27](images/screen27.png)

> **Первая машина:** `sudo su`
> 
> `sudo nano /etc/gitlab-runner/config.toml`
> 
> **добавляем** `environment = ["SSH_AUTH_SOCK=/tmp/ssh-agent"]`

![screen28](images/screen28.png)

> Создание отпечатка удалённого сервера:
> `ssh-keyscan -H 10.20.0.10 >> /home/gitlab-runner/.ssh/known_hosts`
> 

![screen29](images/screen29.png)

> Копируем ключ для работы раннера
> 
> `cp /home/nataliam/.ssh/id_rsa /home/gitlab-runner/.ssh/id_rsa`
> 
> **Но в ключах known_hosts указан root, поэтому необходимо ввести `chown gitlab-runner:gitlab-runner known_hosts`**

![screen30](images/screen30.png)

![screen31](images/screen31.png)

> **Копируем содержимое открытого ключа на удалённую машину**
> `ssh-copy-id nataliam@10.20.0.10`

![screen32](images/screen32.png)

> **Перезапускаем гитлаб-раннер** `sudo systemctl restart gitlab-runner.service`

![screen33](images/screen33.png)

> **На второй машине добавляем возможность копирования для нашего пользователя без ввода  пароля**
> `sudo visudo`
> `nataliam ALL=(ALL) NOPASSWD: /bin/mv`

![screen35](images/screen35.png)

> **Всё готово к проверке**

> **После проведения всех этапов, он ожидает от нас команды**

![screen34](images/screen34.png)

![screen36](images/screen36.png)

> Убираем build и тест для проверки фейла deploy

![screen37](images/screen37.png)

##### Сохрани дампы образов виртуальных машин.
**P.S. Ни в коем случае не сохраняй дампы в гит!**
- Не забудь запустить пайплайн с последним коммитом в репозитории.

![screen38](images/screen38.png)

### Part 6. Дополнительно. Уведомления
**== Задание ==**

##### Настрой уведомления об успешном/неуспешном выполнении пайплайна через бота с именем «[твой nickname] DO6 CI/CD» в *Telegram*.

- Текст уведомления должен содержать информацию об успешности прохождения как этапа **CI**, так и этапа **CD**.
- В остальном текст уведомления может быть произвольным.

> Создаём в `@BotFather` своего бота и получаем API, а в `@getmyid_bot` получаем свой ID

![screen39](images/screen39.png)
![screen40](images/screen40.png)

> Создадим `config.conf на сервере`

![screen41](images/screen41.png)

> Сделаем `notify.sh`, который будет отвечать за обработку

![screen42](images/screen42.png)

> Теперь добавим `.notify: &notify` и вызов после каждого этапа

![screen43](images/screen43.png)

> Итог: теперь нам бот присылает сообщения с результатами этапа

![screen44](images/screen44.png)