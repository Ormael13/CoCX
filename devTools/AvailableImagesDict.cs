using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Text.RegularExpressions;
using System.Threading.Tasks;
using System.Xml;

namespace AvailableImagesDict
{
    class AvailableImagesDict
    {
        public static List<string> imageIDs = new List<string>();
        public static List<string> monsterNames = new List<string>();

        static void Main(string[] args)
        {
            DirSearch(@"../includes");
            File.WriteAllLines(@"./allImages.txt", imageIDs.Concat(monsterNames));

            BuildXMLFile();

            Console.WriteLine("Complete. Found {0} unique items. Press any key to exit.", imageIDs.Count);
            for (int i = 10; i > 0; i--)
            {
                Console.Write("\rAutomatically exiting in " + i + " seconds.");

                for (int j = 20; j > 0; j--)
                {
                    // If the user has pressed a key, break
                    if (Console.KeyAvailable)
                        break;
                    System.Threading.Thread.Sleep(50);
                }
            }

            Console.ReadKey();
        }

        static void DirSearch(string sDir)
        {
            try
            {
                foreach (string f in Directory.GetFiles(sDir, "*.as", SearchOption.AllDirectories))
                {
                    foreach (string line in File.ReadAllLines(f))
                    {
                        foreach (Match match in Regex.Matches(line, "images\\.showImage\\(\"([^\"]*)\""))
                        {
                            if (!imageIDs.Contains(match.Groups[1].Value))
                            {
                                Console.WriteLine("Found {0}", match.Groups[1].Value);
                                imageIDs.Add(match.Groups[1].Value);
                            }
                        }
                        //monster.imageName="sandwitch";
                        foreach (Match match in Regex.Matches(line, "monster\\.imageName\\s*=\\s*\"([^\"]*)\""))
                        {
                            if (!imageIDs.Contains(match.Groups[1].Value))
                            {
                                Console.WriteLine("Found {0}", match.Groups[1].Value);
                                monsterNames.Add("monster-" + match.Groups[1].Value);
                            }
                        }
                    }
                }
            }
            catch (System.Exception excpt)
            {
                Console.WriteLine(excpt.Message);
            }
        }

        public static void BuildXMLFile()
        {
            try
            {
                Directory.CreateDirectory("../img/");
                XmlWriterSettings settings = new XmlWriterSettings();
                settings.Indent = true;
                settings.IndentChars = "\t";
                XmlWriter writer = XmlWriter.Create("../img/images.xml", settings);
                var filters = new String[] { "jpg", "jpeg", "gif", "png" };

                writer.WriteStartDocument();
                writer.WriteStartElement("Images");

                for (int i = 0; i < imageIDs.Count; i++)
                {
                    foreach (string fileType in filters)
                    {
                        writer.WriteStartElement("Image");
                        writer.WriteAttributeString("id", imageIDs[i]);
                        writer.WriteString("./img/" + imageIDs[i] + "." + fileType);
                        writer.WriteEndElement();
                    }
                }

                for (int i = 0; i < monsterNames.Count; i++)
                {
                    foreach (string fileType in filters)
                    {
                        writer.WriteStartElement("Image");
                        writer.WriteAttributeString("id", monsterNames[i]);
                        writer.WriteString("./img/" + monsterNames[i] + "." + fileType);
                        writer.WriteEndElement();
                    }
                }

                writer.WriteEndElement();
                writer.WriteEndDocument();
                writer.Close();
            }
            catch (Exception e)
            {
                Console.WriteLine("Some broke while creating the XML file");
                Console.WriteLine(e.Message);
            }
        }
    }
}
