# Front Despacho

Frontend web para ver compras y gestionar despachos.

## Qué hace

- Muestra compras.
- Permite generar despachos desde una compra.
- Permite revisar y cerrar despachos.

## Cómo funciona con EC2

- Este frontend corre en una EC2 pública.
- Se accede por navegador usando la IP pública de esa EC2.
- El frontend consume 2 APIs:
	- API de ventas (`:8080`)
	- API de despachos (`:8081`)

## Variables importantes

Antes de construir la imagen del frontend, se usan:

- `VITE_API_VENTAS_URL`
- `VITE_API_DESPACHOS_URL`

Si cambias esas URLs, debes reconstruir y volver a desplegar el frontend.

## Despliegue automático (CI/CD)

Al hacer push a la rama `deploy`:

1. Se construye imagen Docker.
2. Se publica en Docker Hub.
3. Se conecta por SSH a EC2.
4. Se actualiza el contenedor `front-despacho`.

Workflow: `.github/workflows/deploy.yml`

## Probar rápido

Abrir en navegador:

- `http://<IP_PUBLICA_FRONT_EC2>`

Comprobar APIs:

```bash
curl http://<IP_BACK_VENTAS>:8080/api/v1/ventas
curl http://<IP_BACK_DESPACHOS>:8081/api/v1/despachos
```
