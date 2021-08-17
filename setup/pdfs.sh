files=(
    chaaya/arm7tdmi-gba.pdf
    chaaya/arm946e-s.pdf
    chaaya/arm946e-s-timing.pdf
    chaaya/armv5.pdf
)

pdf_path=$HOME/pdfs

if [ ! -d "$pdf_path" ]; then
    mkdir $pdf_path
fi
if [ ! -d "$pdf_path/chaaya" ]; then
    mkdir $pdf_path/chaaya
fi

for path in ${files[@]}; do
    full_path=$pdf_path/$path
    if [ ! -f "$full_path" ]; then
        case $path in
        chaaya/arm7tdmi-gba.pdf)
            curl https://cdn.discordapp.com/attachments/465586361731121162/743737575554023494/ARM7TDMI.pdf -o $full_path
            ;;
        chaaya/arm946e-s.pdf)
            curl https://cdn.discordapp.com/attachments/667132407262216272/818608253927686164/ARM946E-S_Technical_Reference_Manual.pdf -o $full_path
            ;;
        chaaya/arm946e-s-timing.pdf)
            curl https://cdn.discordapp.com/attachments/667132407262216272/818608131956408401/ARM9E-S_Technical_Reference_Manual.pdf -o $full_path
            ;;
        chaaya/armv5.pdf)
            curl https://cdn.discordapp.com/attachments/667132407262216272/733255145495986246/ARMv5TE_reference_manual.pdf -o $full_path
            ;;
        *)
            echo "Didn't handle case of $path"
            ;;
        esac
    fi
done
