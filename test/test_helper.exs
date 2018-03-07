ExUnit.start()

# Mock de respuesta del buro
Mox.defmock(Burox.BuroService.Mock, for: Burox.BuroService)
Application.put_env(:burox, :buro_service, Burox.BuroService.Mock)
