# PostgreSQL Deployment

## Описание

Конфигурация и скрипты развёртывания PostgreSQL для backend-сервисов платформы.

## Основные возможности

- deployment PostgreSQL через подготовленные values
- скрипты полного развёртывания и удаления
- параметризация через `apply-new-variables.sh`

## Структура проекта

- `values.bitnami-postgresql.yaml` - основные настройки postgres chart
- `deploy-from-scratch.sh` - установка с нуля
- `rebuild-delete-deploy.sh` - пересборка цикла
- `delete-all.sh` - удаление ресурсов

## Быстрый старт

1. Проверить values-файл.
2. Выполнить `deploy-from-scratch.sh`.
3. Проверить готовность pod/service в namespace.
