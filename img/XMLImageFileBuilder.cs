using System;
using System.Collections;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Drawing;
using System.Threading.Tasks;
using System.Xml;

namespace XMLImageFileBuilder
{
    class XMLImageFileBuilder
    {
        private static List<String> fileName = new List<string>();
        //public struct ImgDim
        //{
        //    public String width;
        //    public String height;
        //}

        public static void BuildXMLFile(String folderPrefix, String directory)
        {
            XmlWriterSettings settings = new XmlWriterSettings();
            settings.Indent = true;
            settings.IndentChars = "\t";
            XmlWriter writer = XmlWriter.Create(directory + "images.xml", settings);

            writer.WriteStartDocument();
            writer.WriteStartElement("Images");

            for (int i = 0; i < fileName.Count; i++)
            {
                writer.WriteStartElement("Image");

                writer.WriteAttributeString("id", Path.GetFileNameWithoutExtension(fileName[i]));
                //writer.WriteAttributeString("width", GetImageInfo(fileName[i]).width);
                //writer.WriteAttributeString("height", GetImageInfo(fileName[i]).height);
                fileName[i] = Path.Combine(folderPrefix, Path.GetFileName(fileName[i]));
                writer.WriteString(fileName[i]);

                writer.WriteEndElement();
            }

            writer.WriteEndElement();
            writer.WriteEndDocument();
            writer.Close();
        }

        public static bool GetImages(String searchFolder, String[] filters)
        {

            bool getFilesSuccess = true;
            try
            {
                foreach (var filter in filters)
                {
                    fileName.AddRange(Directory.GetFiles(searchFolder, String.Format("*.{0}", filter), SearchOption.AllDirectories));
                }

                if (fileName.Count == 0)
                {
                    Console.WriteLine("ERROR: Found no images in " + searchFolder);
                    getFilesSuccess = false;
                }
                foreach (string file in fileName)
                {
                    Console.WriteLine("Found " + file);
                }

                return getFilesSuccess;
            }
            catch (Exception e)
            {
                Console.WriteLine("Failed get images from " + searchFolder + ". Trying current directory...");
                //Console.WriteLine(e.Message);
                return getFilesSuccess = false;
            }
        }

        //public static ImgDim GetImageInfo(String imgPath)
        //{
        //    ImgDim id = new ImgDim();
        //    Image img = Image.FromFile(imgPath);
        //    id.width = img.Width.ToString();
        //    id.height = img.Height.ToString();

        //    return id;
        //}

        static void Main(string[] args)
        {
            // It should be possible to do this without the two variables, by looking
            // for the presence of "/img" in BuildXMLFile, but I'm too lazy to 
            // look up the proper C# string operators at the moment.
            String searchFolder = "./img/";
            String folderPrefix = "./";

            var filters = new String[] { "jpg", "jpeg", "png", "gif" };
            bool success = GetImages(searchFolder, filters);
            if (!success)
            {
                searchFolder = "./";
                folderPrefix = "./img/";
                success = GetImages(searchFolder, filters);
            }

            if (success)
                BuildXMLFile(folderPrefix, searchFolder);


            Console.WriteLine("Complete. Press any key to exit.");
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

        }
    }
}
