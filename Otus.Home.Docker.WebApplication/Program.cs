var builder = WebApplication.CreateBuilder(args);

var app = builder.Build();

app.MapGet("/", () => "Hello, Otus!");
app.MapGet("/health", () => Results.Json(new
{
	status = "OK"
}));


app.Run();