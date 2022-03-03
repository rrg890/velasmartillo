//+------------------------------------------------------------------+
//|                                                     Martillo.mq4 |
//|                                                       Ramón Ruiz |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Ramón Ruiz"
#property link      "https://www.mql5.com"
#property version   "1.00"
#property strict

//+------------------------------------------------------------------+
//| INPUTS                                                           |
//+------------------------------------------------------------------+
input double PorcentajeMecha = 0.7;
input int    DistanciaMinima = 0;

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
int OnInit()
{
    return INIT_SUCCEEDED;
}

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void OnTick()
{
    if (DetectamosNuevaVela())
    {
        if (MechaArriba())
        {
            // Operaciones de venta, entradas SELL o CORTO
            Print("Patrón Martillo modo SELL. Time: " + TimeToString(Time[1]));
        }
        else if (MechaAbajo())
        {
            // Operaciones de compra, entradas BUY o LARGO
            Print("Patrón Martillo modo BUY. Time: " + TimeToString(Time[1]));
        }
    }
}

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool DetectamosNuevaVela()
{
    static datetime fecha;

    if (fecha != Time[0])
    {
        fecha = Time[0];

        return true;
    }

    return false;
}

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool MechaArriba()
{
    double precio = MathMax(Close[1], Open[1]);

    return ((High[1] - precio) / (High[1] - Low[1]) >= PorcentajeMecha && High[1] - Low[1] > DistanciaMinima);
}

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool MechaAbajo()
{
    double precio = MathMin(Close[1], Open[1]);

    return ((precio - Low[1]) / (High[1] - Low[1]) >= PorcentajeMecha && High[1] - Low[1] > DistanciaMinima);
}
//+------------------------------------------------------------------+
