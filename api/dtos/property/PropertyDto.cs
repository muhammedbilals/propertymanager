using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace api.dtos.property
{
    public class PropertyDto
    {
        public string PropertyName { get; set; } = string.Empty;
        public string PropertyType { get; set; } = string.Empty;
        public string Location { get; set; } = string.Empty;
        public int SizeSqFt { get; set; }
        public int Price { get; set; }
        public int NoOfBedrooms { get; set; }   
        public int NoOfBathrooms { get; set; }
    }
}