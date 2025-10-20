void main(void)
{
    unsigned int value, bit, i = 0;
    int flag = 0;

    print_string("Introduza um numero: ");
    value = read_int();
    print_string("\nO valor em binário e': ");

    do{
        bit = value >> 31;
        if (flag == 1 || bit != 0)
        {
            flag = 1;
            if ((i % 4) == 0)
            {
                print_char(' ');
            }
            print_char(0x30 + bit);
        }
        value = value << 1;  //shift left de 1 bit
        i++;
    }while(i < 32);
}

