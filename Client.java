import java.net.*;
import java.io.*;
 
class Client
{
 	public static void main(String args[]) throws IOException 
 	{
		Socket clientSocket = null;
		String str = null;
		BufferedReader in = null;
		BufferedReader br=null;
		PrintWriter out=null;
		in = new BufferedReader(new InputStreamReader(System.in));
		try 
		{
			clientSocket = new Socket(InetAddress.getLocalHost(), 5006);
			out = new PrintWriter(clientSocket.getOutputStream(), true);
			br = new BufferedReader(new InputStreamReader(clientSocket.getInputStream()));
		} 
		catch (UnknownHostException uhe) 
		{
			System.out.println("Unknown Host");
			System.exit(0);
		}
		boolean more = true;
		str = br.readLine();
		System.out.println(str);
		
		while (more) 
		{
			str = in.readLine();
			out.write(str+"\n");
			out.flush();
			String s;
			s = br.readLine();
			
			System.out.println("From server :" + s);
			if (s.trim().equals("bye!")) 
			{
				more=false;
			}

		}
		in.close();
		br.close();
		out.close();
		clientSocket.close();
	}
}
