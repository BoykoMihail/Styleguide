# Формат репорта багов сервера

При обнаружении разработчиком/тестировщиком бага сервера необходимо:

1. Если сервер реализуется на нашей стороне, то завести (через тестировщика) его в jira в нижеописанном формате
2. Если сервер реализуется на стороне заказчика/в другой компании - отправить письмом менеджеру проекта в нижеописанном формате

## Формат репорта бага:

1. Curl (подробнее о том, как получить Curl [здесь](https://github.com/TouchInstinct/Styleguide/blob/master/general/curlGuide.md))
2. Response

**Примечание**: если Response большой, то файл с ним помещается в dropbox и прикрепляется ссылка на него. *Но отдельно выделяется проблемное место в основное описание бага*

3. Описание ошибки: что не так, и как должно быть в документации

### Пример описания

```sh
curl -X POST -i -H "Content-Type: application/json" \ 
-d "{\"session_id\":\"apt566gi9phskcc2cfiuubjag6\",\"id\":39041,\"name_last\":\"\",\"name_first\":\"john\",\"name_middle\":\"\",\"phones\":[\"0000\"],\"emails\":[],\"description\":null}" \
https://api.meradb.ru/v1/contacts/edit/
```

**Response** *(ссылка на файл в dropbox)* :

```json
{
    "result":
    { 
        "id":39041
    },
    "error_code":0,
    "error_message":null
}
```

**Errors**:

`result`->`id`: Value should be string. *id должен быть строкой*
