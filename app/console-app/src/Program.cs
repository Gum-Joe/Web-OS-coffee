using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks; 

namespace console_app
{
    class Program
    {
        static void Main(string[] args)
        {
            Console.WriteLine("Hello, and welcome to the web-os manager app");
            Console.WriteLine("To get started, please give us arguments");
            Console.WriteLine("Help");
            /*if(args.Length == 0){
                Console.WriteLine("Help");
            } else if(args[1] == "install"){
                scripts.install(args[2]);
            } else if(args[1] == "--help"){
                help.showhelp("unspecified");
            }*/
            foreach (string s in args)
        {
            System.Console.WriteLine(s);
        }

        }
    }
}
