void main(void)
{
    unsigned int value, bit, i;
    int flag;

    print_string("Introduza um numero: ");
    value = read_int();
    print_string("\nO valor em binário e': ");

    for(i=0, flag = 0; i < 32; i++)
    {
        bit = value >> 31;
        if (flag == 1 || bit != 0)
        {
            flag = 1;
            if ((i % 4) == 0)
                print_char(' ');
                print_char(0x30 + bit);
            }
        value = value << 1;  //shift left de 1 bit
    }
}

