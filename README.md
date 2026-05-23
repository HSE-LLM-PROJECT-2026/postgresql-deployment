# PostgreSQL Deployment

## Описание

Репозиторий для раскатки PostgreSQL в Kubernetes. База используется сервисами control plane для хранения deployment metadata, релизов, квот, затрат, аудита и пользовательских данных платформы.

## Основные возможности

- Helm values для PostgreSQL
- persistent storage для данных
- deploy/delete/redeploy скрипты
- единая точка настройки DB для сервисов платформы

## Структура проекта

- `values.bitnami-postgresql.yaml` — значения Helm chart
- `deploy-from-scratch.sh` — установка PostgreSQL
- `rebuild-delete-deploy.sh` — переустановка
- `delete-all.sh` — удаление ресурсов
- `apply-new-variables.sh` — применение новых переменных

## Деплой

```bash
./deploy-from-scratch.sh
```

Полная переустановка:

```bash
./rebuild-delete-deploy.sh
```

## Важное

Перед удалением нужно проверить PV/PVC. Если удалить persistent volume без backup, можно потерять данные сервисов.

## Автор

Igor Malysh
