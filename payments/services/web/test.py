import csv


def main():
    with open('./vouchers/vouchers.csv') as csv_file:
        file = csv.reader(csv_file, delimiter=',')
        data = []
        for row in file:
            data.append(row)
        for val in data:
            code = val[0].split(';')[0]
            voucher_type = val[0].split(';')[1]
            print(code)
            print(voucher_type)


if __name__ == "__main__":
    main()
