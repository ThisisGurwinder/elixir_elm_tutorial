defmodule PlatformWeb.PlayerSessionController do
	use PlatformWeb, :controller

	def new(conn, _) do
		render conn, "new.html"
	end
 	
 	def create(conn, %{"_csrf_token" => _csrf_token, "_method" => "delete", "session_id" => session_id}) do
 		delete(conn, session_id)
 	end
	def create(conn, %{"session" => %{"username" => username, "password" => password }}) do
		case PlatformWeb.PlayerAuthController.sign_in_with_username_and_password(conn, username, password, repo: Platform.Repo) do
			{:ok, conn} ->
				conn
				|> put_flash(:info, "welcome back")
				|> redirect(to: page_path(conn, :index))
			{:error, _reason, conn} ->g
				conn
				|> put_flash(:error, "Invalid username/password confirmation")
				|> render("new.html")
		end
	end
 	
    
	def delete(conn, _) do
		conn
		|> PlatformWeb.PlayerAuthController.sign_out()
		|> redirect(to: player_session_path(conn, :new))
	end
end 