import java.io.*;
import java.net.*;
import java.lang.Thread;
 
public class Server
{
	public static void main (String[] args) 
	{
		try 
		{
			ServerSocket server = new ServerSocket(5006);
			System.err.println("Server Started...");
			System.err.println("Listening...");
			while (true) 
			{
				Socket client = server.accept();
				System.err.println("Connection Request acccepted from Client:" + client);
				EchoHandler handler = new EchoHandler(client);
				handler.start();
			}
		}
		catch (Exception e) 
		{
			System.err.println("Exception caught:" + e);
		}
	}
}
 
class EchoHandler extends Thread 
{
	Socket client;
	EchoHandler (Socket client) 
	{
		this.client = client;
	}

	public void run () 
	{
		try 
		{
			BufferedReader reader = new BufferedReader(new InputStreamReader(client.getInputStream()));
			PrintWriter writer = new PrintWriter(client.getOutputStream(), true);
			writer.println("[type 'bye' to disconnect]");
			 
			while (true) 
			{
				Thread t = Thread.currentThread();
      			String tname = t.getName();
      			long tid = t.getId();
      			System.out.println("Thread Name:" + tname + " Thread ID:" +tid);
      			
				String line = reader.readLine();
				System.out.println(line);
				if (line.trim().equals("bye")) 
				{
					writer.println("bye!");
					writer.flush();
					break;
				}
				writer.println("[echo] " + line);
			}
		}
		catch (Exception e) 
		{
			System.err.println("Exception caught: client disconnected.");
		}
		finally 
		{
			try 
			{ 
				client.close(); 
			}
			catch (Exception e ){ ; }
		}
	}
} 
