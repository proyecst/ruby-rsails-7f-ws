nterprise-Grade Solutions for Concurrency, AI, and Fintech
Este repositorio contiene una serie de implementaciones robustas utilizando Ruby 3.3+ y Rails 7.1+, enfocadas en resolver problemas críticos de escalabilidad, integridad de datos y procesamiento asíncrono.

🛠 Proyectos Incluidos
1. Atomic Reservation Engine (Concurrency Control)
Problema: Race conditions en sistemas de alta demanda (Hoteles/Tickets).

Solución: Implementación de Pessimistic Locking (SELECT FOR UPDATE) para garantizar que nunca ocurra una sobreventa.

Tecnologías: PostgreSQL, ActiveRecord Transactions, RSpec (Multi-threading tests).

Archivo Clave: app/services/bookings/create_reservation_service.rb

2. AI Sentiment Analysis Pipeline (Asynchronous Processing)
Problema: Latencia alta al integrar LLMs en el flujo de usuario.

Solución: Arquitectura de procesamiento en segundo plano con Sidekiq. El usuario recibe respuesta inmediata mientras la IA procesa la reseña de forma asíncrona.

Tecnologías: OpenAI API, Sidekiq, Redis, Faraday.

Archivo Clave: app/sidekiq/analyze_sentiment_job.rb

3. Crypto Edge Gateway (Smart Caching)
Problema: Rate limiting en APIs externas y latencia en consultas financieras.

Solución: Capa de Read-Through Caching con Redis que reduce el tiempo de respuesta de ~800ms a <10ms.

Tecnologías: Redis (TTL caching), Faraday, Service Objects.

Archivo Clave: app/services/crypto/price_fetcher_service.rb

🏗 Arquitectura y Patrones de Diseño
Para mantener el código mantenible y escalable, se aplicaron los siguientes patrones:

Service Objects: Lógica de negocio extraída de los controladores para cumplir con el principio de responsabilidad única (SRP).

Concerns: Mixins reutilizables para modelos y controladores.

API-First Approach: Respuestas estructuradas en JSON con manejo de errores estandarizado.

🚀 Instalación y Configuración
Requisitos:
Ruby: 3.3.0

Rails: 7.1.0

Redis: 7.0+

PostgreSQL: 14+

Pasos:
Clonar el repo: git clone <url-del-repo>

Instalar gemas: bundle install

Configurar variables de entorno: * Crea un archivo .env y añade tu OPENAI_ACCESS_TOKEN.

Preparar DB: rails db:prepare

Ejecutar Tests: bundle exec rspec

Iniciar Servidores:

Rails: rails s

Sidekiq: bundle exec sidekiq

🧪 Testing
La calidad del código está garantizada por una cobertura de pruebas con RSpec, incluyendo:

Unit Tests: Validación de lógica en Service Objects.

Concurrency Tests: Simulación de hilos concurrentes para el motor de reservas
