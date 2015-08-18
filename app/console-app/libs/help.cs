using System;

namespace console_app
{
	class help {
		public static void showhelp(string help){
			Console.WriteLine("Help:");
			Console.WriteLine("Install");
			Console.WriteLine("	Usage: install <options> [package] <options>");
			Console.WriteLine("	Info: Used to install a package");
			Console.WriteLine("	Options:");
			Console.WriteLine("	   -l   --loacation");
		}
	}
}