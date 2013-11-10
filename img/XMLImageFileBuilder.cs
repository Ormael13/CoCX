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
        public struct ImgDim
        {
            public String width;
            public String height;
        }

        public static void BuildXMLFile()
        {
            XmlWriterSettings settings = new XmlWriterSettings();
            settings.Indent = true;
            settings.IndentChars = "\t";
            XmlWriter writer = XmlWriter.Create(".\\img\\images.xml", settings);

            writer.WriteStartDocument();
            writer.WriteStartElement("Images");

            for (int i = 0; i < fileName.Count; i++)
            {
                writer.WriteStartElement("Image");

                writer.WriteAttributeString("id", Path.GetFileNameWithoutExtension(fileName[i]));
                writer.WriteAttributeString("width", GetImageInfo(fileName[i]).width);
                writer.WriteAttributeString("height", GetImageInfo(fileName[i]).height);
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
                    Console.WriteLine("ERROR: Found no images. Is this program in the same folder as CoC.swf?");
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
                Console.WriteLine("Failed get images");
                Console.WriteLine(e.Message);
                return getFilesSuccess = false;
            }
        }

        public static ImgDim GetImageInfo(String imgPath)
        {
            ImgDim id = new ImgDim();
            Image img = Image.FromFile(imgPath);
            id.width = img.Width.ToString();
            id.height = img.Height.ToString();

            return id;
        }

        static void Main(string[] args)
        {
            String searchFolder = ".\\img\\";
            var filters = new String[] { "jpg", "jpeg", "png" };
            bool success = GetImages(searchFolder, filters);

            if (success)
                BuildXMLFile();

            Console.ReadKey();
        }
    }
}
